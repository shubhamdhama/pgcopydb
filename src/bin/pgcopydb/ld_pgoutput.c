/*
 * src/bin/pgcopydb/ld_wal2json.c
 *     Implementation of a CLI to copy a database between two Postgres instances
 */

#include <errno.h>
#include <getopt.h>
#include <inttypes.h>
#include <sys/wait.h>
#include <unistd.h>

#include "postgres.h"
#include "postgres_fe.h"
#include "access/xlog_internal.h"
#include "access/xlogdefs.h"
#include "parson.h"

#include "cli_common.h"
#include "cli_root.h"
#include "copydb.h"
#include "env_utils.h"
#include "ld_stream.h"
#include "lock_utils.h"
#include "log.h"
#include "parsing_utils.h"
#include "pidfile.h"
#include "pg_utils.h"
#include "schema.h"
#include "signals.h"
#include "string_utils.h"
#include "summary.h"

typedef enum LogicalRepMsgType
{
	LOGICAL_REP_MSG_BEGIN = 'B',
	LOGICAL_REP_MSG_COMMIT = 'C',
	LOGICAL_REP_MSG_ORIGIN = 'O',
	LOGICAL_REP_MSG_INSERT = 'I',
	LOGICAL_REP_MSG_UPDATE = 'U',
	LOGICAL_REP_MSG_DELETE = 'D',
	LOGICAL_REP_MSG_TRUNCATE = 'T',
	LOGICAL_REP_MSG_RELATION = 'R',
	LOGICAL_REP_MSG_TYPE = 'Y',
	LOGICAL_REP_MSG_MESSAGE = 'M',
	LOGICAL_REP_MSG_STREAM_START = 'S',
	LOGICAL_REP_MSG_STREAM_END = 'E',
	LOGICAL_REP_MSG_STREAM_COMMIT = 'c',
	LOGICAL_REP_MSG_STREAM_ABORT = 'A'
} LogicalRepMsgType;

bool
parsePgoutputMessageActionAndXid(LogicalStreamContext *context)
{
	StreamContext *privateContext = (StreamContext *) context->private;
	LogicalMessageMetadata *metadata = &(privateContext->metadata);

	char *buf = (char *)context->buffer;
	switch (buf[0])
	{
		case LOGICAL_REP_MSG_BEGIN:
			metadata->action = STREAM_ACTION_BEGIN;
			metadata->xid = fe_recvint64(&buf[1 + 8 + 8]);
			break;

		case LOGICAL_REP_MSG_COMMIT:
			metadata->action = STREAM_ACTION_COMMIT;
			break;

		case LOGICAL_REP_MSG_INSERT:
			metadata->action = STREAM_ACTION_INSERT;
			break;

		case LOGICAL_REP_MSG_UPDATE:
			metadata->action = STREAM_ACTION_UPDATE;
			break;

		case LOGICAL_REP_MSG_DELETE:
			metadata->action = STREAM_ACTION_DELETE;
			break;

		case LOGICAL_REP_MSG_TRUNCATE:
			metadata->action = STREAM_ACTION_TRUNCATE;
			break;

		case LOGICAL_REP_MSG_RELATION:
			metadata->action = STREAM_ACTION_PGOUTPUT_RELATION;
			int pos = 1; // skip first byte

			int r_oid = fe_recvint32(&buf[pos]);
			pos += 4;

			char *nsp = &buf[pos];
			pos += strlen(nsp) + 1;

			char *rel = &buf[pos];
			pos += strlen(rel) + 1;

			pos += 1; // replica identity setting

			int16 colcount = fe_recvint16(&buf[pos]);
			pos += 2;
			log_info("relation oid   : %d\n"
					 "namespace      : %s\n"
					 "relation name  : %s\n"
					 "colcount   	 : %d\n",
					 r_oid, nsp, rel, (int)colcount);

			for (int i = 0; i < colcount; ++i)
			{
				pos += 1; // skip flag

				char *colname = &buf[pos];
				pos += strlen(colname) + 1;

				int coltype_oid = fe_recvint32(&buf[pos]);
				pos += 4;

				pos += 4; // type modifier
				log_info("colname   	: %s\n"
						 "coltype_oid   : %d\n",
						 colname, coltype_oid);
			}

			break;

		case LOGICAL_REP_MSG_TYPE:
			metadata->action = STREAM_ACTION_PGOUTPUT_TYPE;
			break;

		case LOGICAL_REP_MSG_ORIGIN:
			metadata->action = STREAM_ACTION_PGOUTPUT_ORIGIN;
			break;

		case LOGICAL_REP_MSG_MESSAGE:

			log_error("No use of LOGICAL_REP_MSG_MESSAGE");
			break;

		default:
			log_error("invalid logical replication message type : %d",
					  buf[0]);
			return false;
	}

	return true;
}

bool
preparePgoutputMessage(LogicalStreamContext *context)
{
	StreamContext *privateContext = (StreamContext *) context->private;

	/* jsonify the message as-is */
	JSON_Value *js = json_value_init_object();
	JSON_Object *jsobj = json_value_get_object(js);

	json_object_set_string(jsobj, "message", "noop");

	char *jsonstr =
		json_serialize_to_string(
			json_object_get_value(jsobj, "message"));

	privateContext->metadata.jsonBuffer = strdup(jsonstr);

	if (privateContext->metadata.jsonBuffer == NULL)
	{
		log_error(ALLOCATION_FAILED_ERROR);
		return false;
	}

	json_value_free(js);
	json_free_serialized_string(jsonstr);
	return true;
}

bool
parsePgoutputMessage(StreamContext *privateContext,
						 char *message,
						 JSON_Value *json)
{
	return false;
}
