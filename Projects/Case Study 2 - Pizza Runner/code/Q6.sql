--What was the maximum number of pizzas delivered in a single order?
SELECT order_id
	,cnt total_cnt_pizza
FROM (
	SELECT order_id
		,count(order_id) cnt
		,rank() OVER (
			ORDER BY count(order_id) DESC
			) rn
	FROM customer_orders
	GROUP BY order_id
	ORDER BY order_id
	)
WHERE rn = 1;