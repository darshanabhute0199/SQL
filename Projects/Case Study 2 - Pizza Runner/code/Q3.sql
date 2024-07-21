--How many successful orders were delivered by each runner?
SELECT runner_id runner
	,count(order_id) total_orders
FROM runner_orders
WHERE decode(cancellation, 'null', NULL, cancellation) IS NULL
GROUP BY runner_id
ORDER BY runner_id;