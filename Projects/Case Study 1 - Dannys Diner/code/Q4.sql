--What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT m.product_name
	,count(s.product_id) purchase_cnt
FROM sales s
	,menu m
WHERE s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY purchase_cnt DESC;