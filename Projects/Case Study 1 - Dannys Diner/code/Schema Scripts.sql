--alter session set nls_date_format = 'yyyy-mm-dd';

-- Create Scripts
CREATE TABLE sales (
  customer_id VARCHAR2(1 byte),
  order_date DATE,
  product_id INTEGER
);

CREATE TABLE menu (
  product_id INTEGER,
  product_name VARCHAR2(5 byte),
  price INTEGER
);

CREATE TABLE members (
  customer_id VARCHAR2(1 byte),
  join_date DATE
);
commit;



--Insert Scripts

--sales

INSERT INTO sales (customer_id, order_date, product_id) VALUES('A', '2021-01-01', 2);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('A', '2021-01-07', 2);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('A', '2021-01-10', 3);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('A', '2021-01-11', 3);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('A', '2021-01-11', 3);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('B', '2021-01-01', 2);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('B', '2021-01-02', 2);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('B', '2021-01-04', 1);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('B', '2021-01-11', 1);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('B', '2021-01-16', 3);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('B', '2021-02-01', 3);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('C', '2021-01-01', 3);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('C', '2021-01-01', 3);
INSERT INTO sales (customer_id, order_date, product_id) VALUES('C', '2021-01-07', 3);
commit;


--menu

INSERT INTO menu (product_id, product_name, price) VALUES (1, 'sushi', 10);
INSERT INTO menu (product_id, product_name, price) VALUES (2, 'curry', 15);
INSERT INTO menu (product_id, product_name, price) VALUES (3, 'ramen', 12);
commit;  


--members

INSERT INTO members (customer_id, join_date) VALUES ('A', '2021-01-07');
INSERT INTO members (customer_id, join_date) VALUES ('B', '2021-01-09');
commit;


-- Revert Scripts

DROP TABLE sales;
DROP TABLE menu;
DROP TABLE members;
commit;
