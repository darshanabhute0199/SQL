-- The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.
SELECT customer
	,order_date
	,product_name
	,price
	,points member
FROM (
	SELECT customer_id customer
		,order_date
		,points
		,product_name
		,price
		,NULL rn
	FROM (
		SELECT s.customer_id
			,s.order_date
			,m.join_date
			,s.product_id
			,mu.price
			,mu.product_name
			,CASE 
				WHEN (s.order_date >= m.join_date)
					THEN 'Y'
				ELSE 'N'
				END points
		FROM sales s
			,members m
			,menu mu
		WHERE s.customer_id = m.customer_id(+)
			AND s.product_id = mu.product_id
		ORDER BY s.customer_id
			,s.order_date
		)
	WHERE points = 'N'
	
	UNION ALL
	
	SELECT customer_id customer
		,order_date
		,points
		,product_name
		,price
		,rank() OVER (
			PARTITION BY customer_id ORDER BY ORDER_DATE
			) rn
	FROM (
		SELECT s.customer_id
			,s.order_date
			,m.join_date
			,s.product_id
			,mu.price
			,mu.product_name
			,CASE 
				WHEN (s.order_date >= m.join_date)
					THEN 'Y'
				ELSE 'N'
				END points
		FROM sales s
			,members m
			,menu mu
		WHERE s.customer_id = m.customer_id(+)
			AND s.product_id = mu.product_id
		ORDER BY s.customer_id
			,s.order_date
		)
	WHERE points = 'Y'
	)
ORDER BY customer
	,member
	,rn;