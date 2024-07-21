--How many Vegetarian and Meatlovers were ordered by each customer?
SELECT c.customer_id customer
	,c.pizza_id
	,p.pizza_name
	,count(c.pizza_id) count_ordered_pizza
FROM customer_orders c
	,pizza_names p
WHERE c.pizza_id = p.pizza_id
GROUP BY c.customer_id
	,c.pizza_id
	,p.pizza_name
ORDER BY c.customer_id
	,c.pizza_id
	,p.pizza_name;