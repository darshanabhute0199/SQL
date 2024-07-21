--What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
SELECT runner_id
	,round(avg(minutes), 2) avg_time_in_min
FROM (
	SELECT runner_id
		,order_time
		,pickup_time
		,to_number(replace(to_char(extract(minute FROM (order_time - pickup_time))), '-', '')) minutes
	FROM (
		SELECT runner_id
			,order_time
			,to_timestamp(Decode(PICKUP_TIME, 'null', NULL, PICKUP_TIME)) PICKUP_TIME
		FROM runner_orders ro
			,customer_orders c
		WHERE c.order_id = ro.order_id
			AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
		)
	)
GROUP BY runner_id;