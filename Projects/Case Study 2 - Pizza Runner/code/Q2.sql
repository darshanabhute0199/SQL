--How many unique customer orders were made?
SELECT count(DISTINCT CUSTOMER_ID) total_unique_customer
FROM customer_orders;