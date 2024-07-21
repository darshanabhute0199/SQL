--Which item was purchased first by the customer after they became a member?
SELECT a.customer_id customer
	,a.join_date
	,a.order_date
	,mu.product_name
FROM (
	SELECT s.customer_id
		,s.order_date
		,m.join_date
		,s.product_id
		,row_number() OVER (
			PARTITION BY s.customer_id ORDER BY s.customer_id
			) rn
	FROM sales s
		,members m
	WHERE s.customer_id = m.customer_id
		AND s.order_date >= m.join_date
	ORDER BY s.customer_id
		,s.order_date
	) a
	,menu mu
WHERE a.product_id = mu.product_id
	AND a.rn = 1
ORDER BY customer;