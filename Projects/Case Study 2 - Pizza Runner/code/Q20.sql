/*Generate an order item for each record in the customers_orders table in the format of one of the following:
Meat Lovers
Meat Lovers - Exclude Beef
Meat Lovers - Extra Bacon
Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers*/
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
SELECT data.order_id
	,CASE 
		WHEN data.exclusion IS NOT NULL
			AND data.extra IS NOT NULL
			THEN pn.pizza_name || ' - ' || data.exclusion || ' - ' || data.extra
		WHEN data.exclusion IS NOT NULL
			AND data.extra IS NULL
			THEN pn.pizza_name || ' - ' || data.exclusion
		WHEN data.exclusion IS NULL
			AND data.extra IS NOT NULL
			THEN pn.pizza_name || ' - ' || data.extra
		ELSE pn.pizza_name
		END order_item
FROM (
	SELECT order_id
		,pizza_id
		,exclusion
		,extra
	FROM (
		SELECT order_id
			,pizza_id
			,CASE 
				WHEN pt1.TOPPING_NAME IS NOT NULL
					THEN 'Exclude ' || pt1.TOPPING_NAME
				ELSE NULL
				END exclusion
			,CASE 
				WHEN pt2.TOPPING_NAME IS NOT NULL
					THEN 'Extra ' || pt2.TOPPING_NAME
				ELSE NULL
				END extra
		FROM only_pizza_or_singltopp a
			,pizza_toppings pt1
			,pizza_toppings pt2
		WHERE a.EXCLUSIONS = pt1.topping_id(+)
			AND a.EXTRAS = pt2.topping_id(+)
		ORDER BY order_id
			,pizza_id
		)
	
	UNION ALL
	
	SELECT order_id
		,pizza_id
		,exclusion
		,extra
	FROM (
		SELECT order_id
			,pizza_id
			,listagg(exclusion, '') exclusion
			,listagg(extra, '') extra
		FROM (
			SELECT order_id
				,pizza_id
				,CASE 
					WHEN flag = 1
						THEN 'Exclude ' || topping_name
					ELSE NULL
					END exclusion
				,CASE 
					WHEN flag = 2
						THEN 'Extra ' || topping_name
					ELSE NULL
					END extra
			FROM (
				SELECT order_id
					,pizza_id
					,flag
					,listagg(topping_name, ',') topping_name
				FROM (
					SELECT order_id
						,pizza_id
						,topping_name
						,CASE 
							WHEN EXCLUSIONS_ID IS NOT NULL
								THEN 1
							ELSE 2
							END flag
					FROM (
						SELECT order_id
							,pizza_id
							,to_number(EXCLUSIONS_ID) EXCLUSIONS_ID
							,to_number(EXTRAS_ID) EXTRAS_ID
							,topping_name
						FROM (
							SELECT order_id
								,pizza_id
								,EXCLUSIONS_ID
								,extras_id
								,pt.topping_name
							FROM (
								SELECT order_id
									,pizza_id
									,REGEXP_SUBSTR(exclusions, '[^, ]+', 1, LEVEL) exclusions_id
									,'' extras_id
								FROM pizza_with_multoppings CONNECT BY LEVEL <= (
										SELECT LENGTH(REPLACE(exclusions, ', ', NULL))
										FROM pizza_with_multoppings
										)
								) exc
								,pizza_toppings pt
							WHERE exc.exclusions_id = pt.topping_id
							
							UNION ALL
							
							SELECT order_id
								,pizza_id
								,EXCLUSIONS_ID
								,extras_id
								,pt.topping_name
							FROM (
								SELECT order_id
									,pizza_id
									,'' exclusions_id
									,REGEXP_SUBSTR(extras, '[^, ]+', 1, LEVEL) extras_id
								FROM pizza_with_multoppings CONNECT BY LEVEL <= (
										SELECT LENGTH(REPLACE(extras, ', ', NULL))
										FROM pizza_with_multoppings
										)
								) ext
								,pizza_toppings pt
							WHERE ext.extras_id = pt.topping_id
							)
						)
					)
				GROUP BY order_id
					,pizza_id
					,flag
				)
			)
		GROUP BY order_id
			,pizza_id
		)
	) data
	,pizza_names pn
WHERE data.pizza_id = pn.pizza_id;