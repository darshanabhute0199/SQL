--alter session set nls_date_format = 'yyyy-mm-dd';
--alter session set nls_timestamp_format = 'YYYY-MM-DD HH24:MI:SS';

--Create Scripts

CREATE TABLE runners (
  runner_id Number(10,0),
  registration_date DATE
);

CREATE TABLE customer_orders (
  order_id Number(10,0),
  customer_id Number(10,0),
  pizza_id Number(10,0),
  exclusions VARCHAR2(4 byte),
  extras VARCHAR2(4 byte),
  order_time TIMESTAMP
);

CREATE TABLE runner_orders (
  order_id Number(10,0),
  runner_id Number(10,0),
  pickup_time VARCHAR2(19 byte),
  distance VARCHAR2(7 byte),
  duration VARCHAR2(10 byte),
  cancellation VARCHAR2(23 byte)
);

CREATE TABLE pizza_names (
  pizza_id Number(10,0),
  pizza_name Varchar2(100 byte)
);

CREATE TABLE pizza_recipes (
  pizza_id Number(10,0),
  toppings VARCHAR2(50 byte)
);


CREATE TABLE pizza_toppings (
  topping_id Number(10,0),
  topping_name VARCHAR2(50 byte)
);

commit;



--Insert Scripts

--runners

INSERT INTO runners (runner_id, registration_date) VALUES (1, '2021-01-01');
INSERT INTO runners (runner_id, registration_date) VALUES (2, '2021-01-03');
INSERT INTO runners (runner_id, registration_date) VALUES (3, '2021-01-08');
INSERT INTO runners (runner_id, registration_date) VALUES (4, '2021-01-15');
commit;



--customer_orders

INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('1', '101', '1', '', '', '2020-01-01 18:05:02');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('2', '101', '1', '', '', '2020-01-01 19:00:52');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('3', '102', '1', '', '', '2020-01-02 23:51:23');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('3', '102', '2', '', NULL, '2020-01-02 23:51:23');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('4', '103', '1', '4', '', '2020-01-04 13:23:46');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('4', '103', '1', '4', '', '2020-01-04 13:23:46');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('4', '103', '2', '4', '', '2020-01-04 13:23:46');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49');
INSERT INTO customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) VALUES ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');
commit;


--runner_orders

INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', '');
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', '');
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL);
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL);
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL);
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation');
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null');
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null');
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('9', '2', 'null', 'null', 'null', 'Customer Cancellation');
INSERT INTO runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) VALUES ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');
commit;


--pizza_names

INSERT INTO pizza_names (pizza_id, pizza_name) VALUES (1, 'Meatlovers');
INSERT INTO pizza_names (pizza_id, pizza_name) VALUES (2, 'Vegetarian');
commit;



--pizza_recipes

INSERT INTO pizza_recipes (pizza_id, toppings) VALUES (1, '1, 2, 3, 4, 5, 6, 8, 10');
INSERT INTO pizza_recipes (pizza_id, toppings) VALUES (2, '4, 6, 7, 9, 11, 12');
commit;



--pizza_toppings

INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (1, 'Bacon');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (2, 'BBQ Sauce');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (3, 'Beef');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (4, 'Cheese');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (5, 'Chicken');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (6, 'Mushrooms');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (7, 'Onions');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (8, 'Pepperoni');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (9, 'Peppers');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (10, 'Salami');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (11, 'Tomatoes');
INSERT INTO pizza_toppings (topping_id, topping_name) VALUES (12, 'Tomato Sauce');
commit;


--Custom table : Reference of pizza_recipes

create table 
pizza_recipes1
as
 WITH pizza1 AS (SELECT pizza_id,TOPPINGS STR  FROM pizza_recipes where pizza_id = 1)   
 ,pizza2 AS (SELECT pizza_id,TOPPINGS STR  FROM pizza_recipes where pizza_id = 2)   
 select
 pizza_id
 ,SPLIT_VALUES toppings
 from
 (
 SELECT   
 pizza_id,
 REGEXP_SUBSTR (STR, '[^, ]+', 1, LEVEL) SPLIT_VALUES  FROM pizza1 
 CONNECT BY LEVEL <= (SELECT LENGTH (REPLACE (STR, ', ', NULL)) FROM pizza1)
 )
 where split_values is not null
 union all
 select
 pizza_id
 ,SPLIT_VALUES toppings
 from
 (
 SELECT   
 pizza_id,
 REGEXP_SUBSTR (STR, '[^, ]+', 1, LEVEL) SPLIT_VALUES  FROM pizza2 
 CONNECT BY LEVEL <= (SELECT LENGTH (REPLACE (STR, ', ', NULL)) FROM pizza2)
 )
 where split_values is not null;
 
commit;


--Revert Scripts

drop table runners;
drop table pizza_names;
drop table pizza_recipes;
drop table pizza_recipes1;
drop table pizza_toppings;
drop table customer_orders;
drop table runner_orders;
commit;