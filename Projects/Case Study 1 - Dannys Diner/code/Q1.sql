--What is the total amount each customer spent at the restaurant?
SELECT s.CUSTOMER_ID customer
	,sum(mu.price) total_amount
FROM menu mu
	,sales s
WHERE s.product_id = mu.product_id
GROUP BY s.CUSTOMER_ID
ORDER BY customer;