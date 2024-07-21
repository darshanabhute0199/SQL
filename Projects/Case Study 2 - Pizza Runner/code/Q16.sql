--What is the successful delivery percentage for each runner?
SELECT runner_id
	,cnt_order
	,total_order_cnt
	,(cnt_order / total_order_cnt) * 100 successfull_delivery_per
FROM (
	SELECT runner_id
		,cnt_order
		,(
			SELECT count(DISTINCT order_id)
			FROM customer_orders
			) total_order_cnt
	FROM (
		SELECT ro.runner_id
			,count(ro.order_id) cnt_order
		FROM runner_orders ro
		WHERE decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
		GROUP BY ro.runner_id
		ORDER BY ro.runner_id
		)
	);