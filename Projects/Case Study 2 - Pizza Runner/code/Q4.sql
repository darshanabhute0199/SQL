--How many of each type of pizza was delivered?
SELECT pizza_id pizza
	,count(order_id) total_pizza_deliverd
FROM customer_orders co
	,runner_orders ro
WHERE co.order_id = ro.order_id
	AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
GROUP BY pizza_id
ORDER BY pizza_id;