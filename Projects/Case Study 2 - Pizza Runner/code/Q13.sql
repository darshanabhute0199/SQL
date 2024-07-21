--What was the average distance travelled for each customer?
SELECT customer_id
	,round(avg(distance), 2) avg_distance_covered
FROM (
	SELECT c.customer_id
		,to_number(replace(ro.distance, 'km', '')) distance
	FROM runner_orders ro
		,customer_orders c
	WHERE c.order_id = ro.order_id
		AND decode(ro.distance, 'null', NULL, ro.distance) IS NOT NULL
	ORDER BY c.customer_id
	)
GROUP BY customer_id
ORDER BY customer_id;