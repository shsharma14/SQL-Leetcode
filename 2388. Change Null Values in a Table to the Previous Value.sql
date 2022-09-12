-- https://www.youtube.com/watch?v=Xh0EevUOWF0
-- Ankit Bansal (Last Not Null Value | Data Analytics)

USE demo
GO

DROP TABLE IF EXISTS CoffeeShop
GO

Create table CoffeeShop (id int, drink varchar(20))
Truncate table CoffeeShop
insert into CoffeeShop (id, drink) values ('9', 'Mezcal Margarita')
insert into CoffeeShop (id, drink) values ('6', NULL)
insert into CoffeeShop (id, drink) values ('7', NULL)
insert into CoffeeShop (id, drink) values ('3', 'Americano')
insert into CoffeeShop (id, drink) values ('1', 'Daiquiri')
insert into CoffeeShop (id, drink) values ('2', NULL)

SELECT *
FROM CoffeeShop
GO


-- First, we will generate a row number.
-- Then, we will find the range of values between non-null values.
WITH t1 AS (
	SELECT *,
	ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn -- We can't use constants or integer indices with ORDER BY but can use SELECT NULL
	FROM CoffeeShop
), t2 AS (
	SELECT *,
	LEAD(rn,1) OVER (ORDER BY rn) AS next_val      --- can use a very big default value lik 99999999, then we don't have to put NULL condition below.
	FROM t1 WHERE drink IS NOT NULL
)
SELECT t1.id, t2.drink
FROM t1 INNER JOIN t2 ON t1.rn >= t2.rn AND (t1.rn < t2.next_val OR t2.next_val IS NULL)