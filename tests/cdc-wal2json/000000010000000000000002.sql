-- KEEPALIVE {"lsn":"0/2448720","timestamp":"2023-06-14 11:34:23.437739+0000"}
BEGIN; -- {"xid":491,"lsn":"0/244B3D0","timestamp":"2023-06-14 11:34:23.438636+0000","commit_lsn":"0/244B838"}
INSERT INTO "public"."rental" ("rental_id", "rental_date", "inventory_id", "customer_id", "return_date", "staff_id", "last_update") overriding system value VALUES (16050, E'2022-06-01 00:00:00+00', 371, 291, NULL, 1, E'2022-06-01 00:00:00+00');
INSERT INTO "public"."payment_p2022_06" ("payment_id", "customer_id", "staff_id", "rental_id", "amount", "payment_date") overriding system value VALUES (32099, 291, 1, 16050, 5.99, E'2022-06-01 00:00:00+00');
COMMIT; -- {"xid":491,"lsn":"0/244B838","timestamp":"2023-06-14 11:34:23.438636+0000"}
BEGIN; -- {"xid":492,"lsn":"0/244B838","timestamp":"2023-06-14 11:34:23.439932+0000","commit_lsn":"0/244C920"}
UPDATE "public"."payment_p2022_02" SET "amount" = 11.95 WHERE "payment_id" = 23757 and "customer_id" = 116 and "staff_id" = 2 and "rental_id" = 14763 and "amount" = 11.99 and "payment_date" = E'2022-02-11 03:52:25.634006+00';
UPDATE "public"."payment_p2022_02" SET "amount" = 11.95 WHERE "payment_id" = 24866 and "customer_id" = 237 and "staff_id" = 2 and "rental_id" = 11479 and "amount" = 11.99 and "payment_date" = E'2022-02-07 18:37:34.579143+00';
UPDATE "public"."payment_p2022_03" SET "amount" = 11.95 WHERE "payment_id" = 17055 and "customer_id" = 196 and "staff_id" = 2 and "rental_id" = 106 and "amount" = 11.99 and "payment_date" = E'2022-03-18 18:50:39.243747+00';
UPDATE "public"."payment_p2022_03" SET "amount" = 11.95 WHERE "payment_id" = 28799 and "customer_id" = 591 and "staff_id" = 2 and "rental_id" = 4383 and "amount" = 11.99 and "payment_date" = E'2022-03-08 16:41:23.911522+00';
UPDATE "public"."payment_p2022_04" SET "amount" = 11.95 WHERE "payment_id" = 20403 and "customer_id" = 362 and "staff_id" = 1 and "rental_id" = 14759 and "amount" = 11.99 and "payment_date" = E'2022-04-16 04:35:36.904758+00';
UPDATE "public"."payment_p2022_05" SET "amount" = 11.95 WHERE "payment_id" = 17354 and "customer_id" = 305 and "staff_id" = 1 and "rental_id" = 2166 and "amount" = 11.99 and "payment_date" = E'2022-05-12 11:28:17.949049+00';
UPDATE "public"."payment_p2022_06" SET "amount" = 11.95 WHERE "payment_id" = 22650 and "customer_id" = 204 and "staff_id" = 2 and "rental_id" = 15415 and "amount" = 11.99 and "payment_date" = E'2022-06-11 11:17:22.428079+00';
UPDATE "public"."payment_p2022_06" SET "amount" = 11.95 WHERE "payment_id" = 24553 and "customer_id" = 195 and "staff_id" = 2 and "rental_id" = 16040 and "amount" = 11.99 and "payment_date" = E'2022-06-15 02:21:00.279776+00';
UPDATE "public"."payment_p2022_07" SET "amount" = 11.95 WHERE "payment_id" = 28814 and "customer_id" = 592 and "staff_id" = 1 and "rental_id" = 3973 and "amount" = 11.99 and "payment_date" = E'2022-07-06 12:15:38.928947+00';
UPDATE "public"."payment_p2022_07" SET "amount" = 11.95 WHERE "payment_id" = 29136 and "customer_id" = 13 and "staff_id" = 2 and "rental_id" = 8831 and "amount" = 11.99 and "payment_date" = E'2022-07-22 16:15:40.797771+00';
COMMIT; -- {"xid":492,"lsn":"0/244C920","timestamp":"2023-06-14 11:34:23.439932+0000"}
BEGIN; -- {"xid":493,"lsn":"0/244CAE0","timestamp":"2023-06-14 11:34:23.440143+0000","commit_lsn":"0/244CBF0"}
DELETE FROM "public"."payment_p2022_06" WHERE "payment_id" = 32099 and "customer_id" = 291 and "staff_id" = 1 and "rental_id" = 16050 and "amount" = 5.99 and "payment_date" = E'2022-06-01 00:00:00+00';
DELETE FROM "public"."rental" WHERE "rental_id" = 16050;
COMMIT; -- {"xid":493,"lsn":"0/244CBF0","timestamp":"2023-06-14 11:34:23.440143+0000"}
BEGIN; -- {"xid":494,"lsn":"0/244CBF0","timestamp":"2023-06-14 11:34:23.440564+0000","commit_lsn":"0/244D170"}
UPDATE "public"."payment_p2022_02" SET "amount" = 11.99 WHERE "payment_id" = 23757 and "customer_id" = 116 and "staff_id" = 2 and "rental_id" = 14763 and "amount" = 11.95 and "payment_date" = E'2022-02-11 03:52:25.634006+00';
UPDATE "public"."payment_p2022_02" SET "amount" = 11.99 WHERE "payment_id" = 24866 and "customer_id" = 237 and "staff_id" = 2 and "rental_id" = 11479 and "amount" = 11.95 and "payment_date" = E'2022-02-07 18:37:34.579143+00';
UPDATE "public"."payment_p2022_03" SET "amount" = 11.99 WHERE "payment_id" = 17055 and "customer_id" = 196 and "staff_id" = 2 and "rental_id" = 106 and "amount" = 11.95 and "payment_date" = E'2022-03-18 18:50:39.243747+00';
UPDATE "public"."payment_p2022_03" SET "amount" = 11.99 WHERE "payment_id" = 28799 and "customer_id" = 591 and "staff_id" = 2 and "rental_id" = 4383 and "amount" = 11.95 and "payment_date" = E'2022-03-08 16:41:23.911522+00';
UPDATE "public"."payment_p2022_04" SET "amount" = 11.99 WHERE "payment_id" = 20403 and "customer_id" = 362 and "staff_id" = 1 and "rental_id" = 14759 and "amount" = 11.95 and "payment_date" = E'2022-04-16 04:35:36.904758+00';
UPDATE "public"."payment_p2022_05" SET "amount" = 11.99 WHERE "payment_id" = 17354 and "customer_id" = 305 and "staff_id" = 1 and "rental_id" = 2166 and "amount" = 11.95 and "payment_date" = E'2022-05-12 11:28:17.949049+00';
UPDATE "public"."payment_p2022_06" SET "amount" = 11.99 WHERE "payment_id" = 22650 and "customer_id" = 204 and "staff_id" = 2 and "rental_id" = 15415 and "amount" = 11.95 and "payment_date" = E'2022-06-11 11:17:22.428079+00';
UPDATE "public"."payment_p2022_06" SET "amount" = 11.99 WHERE "payment_id" = 24553 and "customer_id" = 195 and "staff_id" = 2 and "rental_id" = 16040 and "amount" = 11.95 and "payment_date" = E'2022-06-15 02:21:00.279776+00';
UPDATE "public"."payment_p2022_07" SET "amount" = 11.99 WHERE "payment_id" = 28814 and "customer_id" = 592 and "staff_id" = 1 and "rental_id" = 3973 and "amount" = 11.95 and "payment_date" = E'2022-07-06 12:15:38.928947+00';
UPDATE "public"."payment_p2022_07" SET "amount" = 11.99 WHERE "payment_id" = 29136 and "customer_id" = 13 and "staff_id" = 2 and "rental_id" = 8831 and "amount" = 11.95 and "payment_date" = E'2022-07-22 16:15:40.797771+00';
COMMIT; -- {"xid":494,"lsn":"0/244D170","timestamp":"2023-06-14 11:34:23.440564+0000"}
-- KEEPALIVE {"lsn":"0/244D170","timestamp":"2023-06-14 11:34:23.440632+0000"}
-- ENDPOS {"lsn":"0/244D170"}
