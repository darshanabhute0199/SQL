--What was the difference between the longest and shortest delivery times for all orders?
SELECT min(duration) min_duration
	,max(duration) max_duration
	,max(duration) - min(duration) difference
FROM (
	SELECT c.ORDER_ID
		,to_number(REGEXP_REPLACE(DURATION, '[^0-9]')) DURATION
	FROM runner_orders ro
		,customer_orders c
	WHERE c.order_id = ro.order_id
		AND decode(ro.DURATION, 'null', NULL, ro.DURATION) IS NOT NULL
	);