--How many days has each customer visited the restaurant?
SELECT CUSTOMER_ID customer
	,count(DISTINCT order_date) total_days_visited
FROM sales
GROUP BY CUSTOMER_ID
ORDER BY CUSTOMER_ID;