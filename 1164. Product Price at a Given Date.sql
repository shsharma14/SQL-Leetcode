USE demo
GO

DROP TABLE IF EXISTS Products 
GO

Create table Products (product_id int, new_price int, change_date date)
Truncate table Products
insert into Products (product_id, new_price, change_date) values ('1', '20', '2019-08-14')
insert into Products (product_id, new_price, change_date) values ('2', '50', '2019-08-14')
insert into Products (product_id, new_price, change_date) values ('1', '30', '2019-08-15')
insert into Products (product_id, new_price, change_date) values ('1', '35', '2019-08-16')
insert into Products (product_id, new_price, change_date) values ('2', '65', '2019-08-17')
insert into Products (product_id, new_price, change_date) values ('3', '20', '2019-08-18')

SELECT * FROM Products
go

-- Solution 1
WITH src AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rn
FROM Products
WHERE change_date < '2019-08-17'
) 
SELECT product_id, new_price AS price
FROM src
WHERE rn = 1
UNION 
SELECT product_id, 10 
FROM Products 
WHERE Product_id NOT IN (SELECT Product_id FROM src)



-- Solution 2

SELECT product_id, new_price AS price FROM (
SELECT product_id, new_price,
RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC) AS rn 
FROM Products
WHERE change_date < '2019-08-17'
) A
WHERE rn = 1
UNION
SELECT product_id, 10 AS price
FROM Products
GROUP BY product_id 
HAVING MIN(change_date) > '2019-08-16'


