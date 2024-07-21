--What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT runner_id
	,avg(speed) avg_speed
FROM (
	SELECT runner_id
		,round(distance / duration, 2) speed
	FROM (
		SELECT ro.runner_id
			,to_number(replace(ro.distance, 'km', '')) distance
			,to_number(REGEXP_REPLACE(DURATION, '[^0-9]')) DURATION
		FROM runner_orders ro
			,customer_orders c
		WHERE c.order_id = ro.order_id
			AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
		)
	)
GROUP BY runner_id
ORDER BY runner_id;