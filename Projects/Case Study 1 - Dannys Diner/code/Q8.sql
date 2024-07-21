--What is the total items and amount spent for each member before they became a member?
SELECT a.customer_id customer
	,count(a.product_id) total_items_purchase
	,sum(mu.price) total_amount
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
WHERE a.product_id = mu.product_id
GROUP BY a.customer_id
ORDER BY a.customer_id;