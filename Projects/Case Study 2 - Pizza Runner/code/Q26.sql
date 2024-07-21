/*Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
customer_id
order_id
runner_id
rating
order_time
pickup_time
Time between order and pickup
Delivery duration
Average speed
Total number of pizzas*/
--alter session set nls_timestamp_format = 'YYYY-MM-DD HH24:MI:SS';
SELECT customer_id
	,order_id
	,runner_id
	,avg(rating) rating
	,order_time
	,pickup_time
	,time_between
	,duration
	,avg(speed) avg_speed
	,count(pizza_id) total_no_pizzas
FROM (
	SELECT co.customer_id
		,co.order_id
		,ro.runner_id
		,r.rating
		,co.order_time
		,ro.pickup_time
		,to_number(replace(to_char(extract(minute FROM (co.order_time - to_timestamp(Decode(ro.PICKUP_TIME, 'null', NULL, ro.PICKUP_TIME))))), '-', '')) time_between
		,to_number(replace(ro.distance, 'km', '')) distance
		,to_number(REGEXP_REPLACE(DURATION, '[^0-9]')) DURATION
		,round(to_number(replace(ro.distance, 'km', '')) / to_number(REGEXP_REPLACE(DURATION, '[^0-9]')), 2) speed
		,co.pizza_id
	FROM customer_orders co
		,runner_orders ro
		,rating r
	WHERE co.order_id = ro.order_id
		AND co.customer_id = r.customer_id
		AND ro.runner_id = r.runner_id
		AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
	)
GROUP BY customer_id
	,order_id
	,runner_id
	,order_time
	,pickup_time
	,time_between
	,duration
ORDER BY customer_id
	,order_id
	,runner_id
	,order_time
	,pickup_time
	,time_between
	,duration;