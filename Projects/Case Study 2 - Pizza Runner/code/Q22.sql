-- What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
WITH only_pizza_or_singltopp
AS (
	SELECT *
	FROM (
		SELECT order_id
			,pizza_id
			,exclusions
			,extras
			,CASE 
				WHEN INSTR(exclusions, ',', 1) > 0
					OR INSTR(extras, ',', 1) > 0
					THEN 0
				ELSE 1
				END flag
		FROM (
			SELECT co.order_id
				,co.pizza_id
				,decode(co.exclusions, 'null', NULL, co.exclusions) exclusions
				,decode(co.extras, 'null', NULL, co.extras) extras
			FROM customer_orders co
				,runner_orders ro
			WHERE co.order_id = ro.order_id
				AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
			)
		)
	WHERE flag = 1
	)
	,pizza_with_multoppings
AS (
	SELECT order_id
		,pizza_id
		,exclusions
		,extras
	FROM (
		SELECT order_id
			,pizza_id
			,exclusions
			,extras
			,CASE 
				WHEN INSTR(exclusions, ',', 1) > 0
					OR INSTR(extras, ',', 1) > 0
					THEN 0
				ELSE 1
				END flag
		FROM (
			SELECT co.order_id
				,co.pizza_id
				,decode(co.exclusions, 'null', NULL, co.exclusions) exclusions
				,decode(co.extras, 'null', NULL, co.extras) extras
			FROM customer_orders co
				,runner_orders ro
			WHERE co.order_id = ro.order_id
				AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
			)
		) a
	WHERE flag = 0
	)
SELECT ingredient
	,quantity
FROM (
	SELECT topping_name ingredient
		,count(topping_name) quantity
	FROM (
		SELECT topping_name
		FROM (
			SELECT pt.topping_name
			FROM customer_orders co
				,runner_orders ro
				,pizza_names pn
				,pizza_recipes1 pr
				,pizza_toppings pt
			WHERE co.pizza_id = pn.pizza_id
				AND co.order_id = ro.order_id
				AND pn.pizza_id = pr.pizza_id
				AND pr.toppings = pt.topping_id
				AND decode(ro.cancellation, 'null', NULL, ro.cancellation) IS NULL
			ORDER BY co.order_id
			)
		
		UNION ALL
		
		SELECT topping_name
		FROM (
			SELECT pt.topping_name
			FROM only_pizza_or_singltopp os
				,pizza_toppings pt
			WHERE os.extras = pt.topping_id(+)
				AND topping_name IS NOT NULL
			)
		
		UNION ALL
		
		SELECT topping_name
		FROM (
			SELECT pt.topping_name
			FROM (
				SELECT order_id
					,pizza_id
					,REGEXP_SUBSTR(extras, '[^, ]+', 1, LEVEL) extras_id
				FROM pizza_with_multoppings CONNECT BY LEVEL <= (
						SELECT LENGTH(REPLACE(extras, ', ', NULL))
						FROM pizza_with_multoppings
						)
				) ext
				,pizza_toppings pt
			WHERE ext.extras_id = pt.topping_id
				AND topping_name IS NOT NULL
			)
		)
	GROUP BY topping_name
	)
ORDER BY quantity DESC;