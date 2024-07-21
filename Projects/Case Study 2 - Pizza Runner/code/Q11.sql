--How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
SELECT week
	,count(DISTINCT runner_id) runner
FROM (
	SELECT ro.runner_id
		,to_number(to_char(to_date(order_time, 'yyyy-mm-dd hh24:mi:ss'), 'ww')) week
	FROM customer_orders c
		,runner_orders ro
	WHERE c.order_id = ro.order_id
	)
GROUP BY week
ORDER BY week;