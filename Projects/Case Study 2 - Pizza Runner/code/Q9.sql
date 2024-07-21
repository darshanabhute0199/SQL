--What was the total volume of pizzas ordered for each hour of the day?
SELECT days
	,hours
	,count(order_id) orders
FROM (
	SELECT order_id
		,extract(hour FROM ORDER_TIME) hours
		,extract(day FROM ORDER_TIME) days
	FROM customer_orders c
	)
GROUP BY days
	,hours
ORDER BY days
	,hours;