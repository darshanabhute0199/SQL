-- Which item was the most popular for each customer?
SELECT a.customer_id customer
	,m.product_name most_popular_product
FROM (
	SELECT customer_id
		,product_id
		,count(product_id) cnt
		,rank() OVER (
			PARTITION BY customer_id ORDER BY count(product_id) DESC
			) rn
	FROM sales
	GROUP BY customer_id
		,product_id
	ORDER BY customer_id
		,product_id
	) a
	,menu m
WHERE a.product_id = m.product_id
	AND a.rn = 1
ORDER BY a.customer_id
	,m.product_name;