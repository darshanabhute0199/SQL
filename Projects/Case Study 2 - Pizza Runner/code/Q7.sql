--For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
SELECT customer_id
	,count(order_id) total_orders
	,sum(CASE 
			WHEN extra_changes = 0
				THEN 1
			ELSE 0
			END) no_changes_made
	,sum(CASE 
			WHEN extra_changes = 1
				THEN 1
			ELSE 0
			END) extra_changes_made
FROM (
	SELECT customer_id
		,order_id
		,CASE 
			WHEN extras IS NULL
				THEN 0
			ELSE 1
			END extra_changes
	FROM (
		SELECT customer_id
			,order_id
			,decode(extras, 'null', NULL, extras) extras
		FROM customer_orders
		ORDER BY customer_id
			,order_id
			,extras
		)
	)
GROUP BY customer_id
ORDER BY customer_id;