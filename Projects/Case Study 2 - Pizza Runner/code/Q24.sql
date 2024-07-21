/*What if there was an additional $1 charge for any pizza extras?
Add cheese is $1 extra*/
WITH only_pizza_or_singltopp
AS (
	SELECT order_id
		,runner_id
		,pizza_id
		,pizza_name
		,price
		,extras
	FROM (
		SELECT order_id
			,runner_id
			,pizza_id
			,pizza_name
			,extras
			,price
			,CASE 
				WHEN INSTR(extras, ',', 1) > 0
					THEN 0
				ELSE 1
				END flag
		FROM (
			SELECT co.order_id
				,ro.runner_id
				,co.pizza_id
				,pn.pizza_name
				,decode(co.extras, 'null', NULL, co.extras) extras
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
		)
	WHERE flag = 1
	)
	,pizza_with_multoppings
AS (
	SELECT order_id
		,runner_id
		,pizza_id
		,pizza_name
		,price
		,extras
	FROM (
		SELECT order_id
			,runner_id
			,pizza_id
			,pizza_name
			,price
			,extras
			,CASE 
				WHEN INSTR(extras, ',', 1) > 0
					THEN 0
				ELSE 1
				END flag
		FROM (
			SELECT co.order_id
				,ro.runner_id
				,co.pizza_id
				,pn.pizza_name
				,decode(co.extras, 'null', NULL, co.extras) extras
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
		)
	WHERE flag = 0
	)
SELECT runner_id runner
	,sum(total_earn) total_earn
FROM (
	SELECT order_id
		,runner_id
		,pizza_id
		,pizza_name
		,price + NVL(extras_price, 0) total_earn
	FROM (
		SELECT order_id
			,runner_id
			,pizza_id
			,pizza_name
			,price
			,to_number(extras) extras_price
		FROM only_pizza_or_singltopp
		
		UNION ALL
		
		SELECT order_id
			,runner_id
			,pizza_id
			,pizza_name
			,price
			,sum(EXTRAS_PRICE)
		FROM (
			SELECT order_id
				,runner_id
				,pizza_id
				,pizza_name
				,price
				,extras
				,1 extras_price
			FROM (
				SELECT order_id
					,runner_id
					,pizza_id
					,pizza_name
					,price
					,REGEXP_SUBSTR(extras, '[^, ]+', 1, LEVEL) extras
				FROM pizza_with_multoppings CONNECT BY LEVEL <= (
						SELECT LENGTH(REPLACE(extras, ', ', NULL))
						FROM pizza_with_multoppings
						)
				)
			)
		GROUP BY order_id
			,runner_id
			,pizza_id
			,pizza_name
			,price
		)
	)
GROUP BY runner_id;