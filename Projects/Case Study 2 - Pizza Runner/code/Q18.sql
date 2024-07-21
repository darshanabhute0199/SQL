--What was the most commonly added extra?
WITH pizza
AS (
	SELECT replace(listagg(extras, ','), ', ', ',') extras
	FROM (
		SELECT co.order_id
			,co.pizza_id
			,co.extras
		FROM customer_orders co
		WHERE decode(co.extras, 'null', NULL, co.extras) IS NOT NULL
		)
	)
SELECT pt.topping_name most_ordered_extras
FROM (
	SELECT extra_id
	FROM (
		SELECT extra_id
			,cnt
			,row_number() OVER (
				ORDER BY cnt DESC
				) rn
		FROM (
			SELECT extra_id
				,count(extra_id) cnt
			FROM (
				SELECT to_number(a.extras) extra_id
				FROM (
					SELECT REGEXP_SUBSTR(extras, '[^, ]+', 1, LEVEL) extras
					FROM pizza CONNECT BY LEVEL <= (
							SELECT LENGTH(REPLACE(extras, ', ', NULL))
							FROM pizza
							)
					) a
				WHERE extras IS NOT NULL
				)
			GROUP BY extra_id
			)
		)
	WHERE rn = 1
	) a1
	,pizza_toppings pt
WHERE a1.extra_id = pt.topping_id;