--If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?
SELECT runner_id runner
	,sum(total_earn) total_earn
FROM (
	SELECT co.order_id
		,ro.runner_id
		,co.pizza_id
		,pn.pizza_name
		,decode(co.extras, 'null', NULL, co.extras) extras
		,to_number(replace(ro.distance, 'km', '')) distance
		,to_number(replace(ro.distance, 'km', '')) * 0.30 spend_per_distance
		,CASE 
			WHEN co.pizza_id = 1
				THEN 12
			ELSE 10
			END actual_price
		,CASE 
			WHEN co.pizza_id = 1
				THEN 12 - to_number(replace(ro.distance, 'km', '')) * 0.30
			ELSE 10 - to_number(replace(ro.distance, 'km', '')) * 0.30
			END total_earn
	FROM customer_orders co
		,runner_orders ro
		,pizza_names pn
	WHERE co.order_id = ro.order_id
		AND co.pizza_id = pn.pizza_id
		AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
	)
GROUP BY runner_id
ORDER BY runner_id;