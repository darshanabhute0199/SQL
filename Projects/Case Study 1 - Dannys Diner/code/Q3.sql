--What was the first item from the menu purchased by each customer?
SELECT a.customer_id customer
	,m.product_name product_name
FROM (
	SELECT customer_id
		,order_date
		,product_id
		,row_number() OVER (
			PARTITION BY customer_id ORDER BY customer_id
				,order_date
			) rn
	FROM sales
	ORDER BY CUSTOMER_ID
		,order_date
	) a
	,menu m
WHERE a.product_id = m.product_id
	AND a.rn = 1;