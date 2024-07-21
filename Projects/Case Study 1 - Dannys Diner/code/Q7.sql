----Which item was purchased just before the customer became a member?
SELECT a.customer_id customer
	,a.join_date
	,a.order_date
	,mu.product_name
FROM (
	SELECT s.customer_id
		,s.order_date
		,s.product_id
		,m.join_date
		,CASE 
			WHEN (s.order_date < m.join_date)
				OR (
					s.order_date IS NOT NULL
					AND m.join_date IS NULL
					)
				THEN 1
			ELSE 0
			END flag
	FROM sales s
		,members m
	WHERE s.customer_id = m.customer_id(+)
		AND CASE 
			WHEN (s.order_date < m.join_date)
				OR (
					s.order_date IS NOT NULL
					AND m.join_date IS NULL
					)
				THEN 1
			ELSE 0
			END = 1
	) a
	,menu mu
WHERE a.product_id = mu.product_id;