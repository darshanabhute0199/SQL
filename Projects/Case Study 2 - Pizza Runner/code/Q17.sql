-- What are the standard ingredients for each pizza?
SELECT pn.pizza_name
	,pt.TOPPING_NAME
FROM pizza_names pn
	,pizza_recipes1 pr
	,pizza_toppings pt
WHERE pn.pizza_id = pr.pizza_id
	AND pr.TOPPINGS = pt.TOPPING_ID
ORDER BY pn.pizza_name;