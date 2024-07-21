/* Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"*/
SELECT order_id
	,pizza_name || ' : 2x' || toppings order_item
FROM (
	SELECT order_id
		,data.pizza_id
		,data.pizza_name
		,data.rn
		,listagg(pt.topping_name, ',') toppings
	FROM (
		SELECT co.order_id
			,co.pizza_id
			,pn.pizza_name
			,row_number() OVER (
				PARTITION BY co.order_id ORDER BY co.order_id
				) rn
		FROM customer_orders co
			,runner_orders ro
			,pizza_names pn
		WHERE co.pizza_id = pn.pizza_id
			AND co.order_id = ro.order_id
			AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
		ORDER BY co.order_id
		) data
		,pizza_recipes1 pr
		,pizza_toppings pt
	WHERE data.pizza_id = pr.pizza_id
		AND pr.toppings = pt.topping_id
	GROUP BY order_id
		,data.pizza_id
		,data.pizza_name
		,data.rn
	ORDER BY data.order_id
	);