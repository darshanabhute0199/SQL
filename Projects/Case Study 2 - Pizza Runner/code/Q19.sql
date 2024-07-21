--What was the most common exclusion?
WITH pizza
AS (
	SELECT replace(listagg(exclusions, ','), ', ', ',') exclusions
	FROM (
		SELECT co.order_id
			,co.pizza_id
			,co.exclusions
		FROM customer_orders co
		WHERE decode(co.exclusions, 'null', NULL, co.exclusions) IS NOT NULL
		)
	)
SELECT pt.topping_name most_excluded_topping
FROM (
	SELECT exclusions_id
	FROM (
		SELECT exclusions_id
			,cnt
			,row_number() OVER (
				ORDER BY cnt DESC
				) rn
		FROM (
			SELECT exclusions_id
				,count(exclusions_id) cnt
			FROM (
				SELECT to_number(a.exclusions_id) exclusions_id
				FROM (
					SELECT REGEXP_SUBSTR(exclusions, '[^, ]+', 1, LEVEL) exclusions_id
					FROM pizza CONNECT BY LEVEL <= (
							SELECT LENGTH(REPLACE(exclusions, ', ', NULL))
							FROM pizza
							)
					) a
				WHERE exclusions_id IS NOT NULL
				)
			GROUP BY exclusions_id
			)
		)
	WHERE rn = 1
	) a1
	,pizza_toppings pt
WHERE a1.exclusions_id = pt.topping_id;