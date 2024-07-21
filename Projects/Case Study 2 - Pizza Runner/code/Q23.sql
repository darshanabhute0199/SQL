--If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
SELECT runner_id runner
	,sum(price) total_earn
FROM (
	SELECT co.order_id
		,ro.runner_id
		,co.pizza_id
		,pn.pizza_name
		,CASE 
			WHEN co.pizza_id = 1
				THEN 12
			ELSE 10
			END price
	FROM customer_orders co
		,runner_orders ro
		,pizza_names pn
	WHERE co.order_id = ro.order_id
		AND co.pizza_id = pn.pizza_id
		AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
	)
GROUP BY runner_id
ORDER BY runner_id;