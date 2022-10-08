USE demo
GO

DROP TABLE IF EXISTS amazon_orders

Create table amazon_orders (order_id int, product_id int, quantity int, purchase_date date)
Truncate table amazon_orders
insert into amazon_orders (order_id, product_id, quantity, purchase_date) values ('1', '1', '7', '2020-03-16')
insert into amazon_orders (order_id, product_id, quantity, purchase_date) values ('2', '1', '4', '2020-12-02')
insert into amazon_orders (order_id, product_id, quantity, purchase_date) values ('3', '1', '7', '2020-05-10')
insert into amazon_orders (order_id, product_id, quantity, purchase_date) values ('4', '1', '6', '2021-12-23')
insert into amazon_orders (order_id, product_id, quantity, purchase_date) values ('5', '1', '5', '2021-05-21')
insert into amazon_orders (order_id, product_id, quantity, purchase_date) values ('6', '1', '6', '2021-10-11')
insert into amazon_orders (order_id, product_id, quantity, purchase_date) values ('7', '2', '6', '2022-10-11')

SELECT * FROM amazon_orders;

-- Solution
WITH product_count AS (
	SELECT product_id, YEAR(purchase_date) AS [year], COUNT(1) AS cnt
	FROM amazon_orders
	GROUP BY product_id, YEAR(purchase_date)
	HAVING COUNT(1) >= 3
)
SELECT DISTINCT t1.product_id 
FROM product_count t1
INNER JOIN product_count t2 
ON t1.product_id = t2.product_id 
AND t2.year - t1.year = 1








