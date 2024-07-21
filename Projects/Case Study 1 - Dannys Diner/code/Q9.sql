--If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT a.customer_id customer
	,sum(points) total_points
FROM (
	SELECT s.customer_id
		,s.product_id
		,m.product_name
		,m.price
		,CASE 
			WHEN s.product_id = 1
				THEN 20
			ELSE 10
			END points
	FROM sales s
		,menu m
	WHERE s.product_id = m.product_id
	) a
GROUP BY a.customer_id
ORDER BY a.customer_id;