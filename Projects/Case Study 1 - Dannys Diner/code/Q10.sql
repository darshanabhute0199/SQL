--In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi how many points do customer A and B have at the end of January?

SELECT a.customer_id customer
	,sum(points) total_points
FROM (
	SELECT s.customer_id
		,s.order_date
		,m.join_date
		,s.product_id
		,mu.price
		,CASE 
			WHEN (s.order_date >= m.join_date)
				THEN 20
			ELSE 10
			END points
	FROM sales s
		,members m
		,menu mu
	WHERE s.customer_id = m.customer_id
		AND s.product_id = mu.product_id
		AND Extract(Month FROM s.order_date) = 1
	ORDER BY s.customer_id
		,s.order_date
	) a
GROUP BY a.customer_id
ORDER BY a.customer_id;