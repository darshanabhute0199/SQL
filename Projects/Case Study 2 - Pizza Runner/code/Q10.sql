--What was the volume of orders for each day of the week
SELECT week
	,day
	,count(order_id) total_orders
FROM (
	SELECT order_id
		,ORDER_TIME
		,extract(day FROM ORDER_TIME) day
		,to_number(to_char(to_date(order_time, 'yyyy-mm-dd hh24:mi:ss'), 'ww')) week
	FROM customer_orders c
	)
GROUP BY week
	,day
ORDER BY week
	,day;