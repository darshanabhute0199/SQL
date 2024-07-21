--How many pizzas were delivered that had both exclusions and extras?
SELECT order_id orders
FROM customer_orders
WHERE (
		decode(EXCLUSIONS, 'null', NULL, EXCLUSIONS) IS NOT NULL
		AND decode(extras, 'null', NULL, extras) IS NOT NULL
		);