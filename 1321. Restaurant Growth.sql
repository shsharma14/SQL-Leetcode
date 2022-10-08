USE demo
GO

DROP TABLE IF EXISTS Customer;


Create table Customer (customer_id int, name varchar(20), visited_on date, amount int)
Truncate table Customer
insert into Customer (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-01', '100')
insert into Customer (customer_id, name, visited_on, amount) values ('2', 'Daniel', '2019-01-02', '110')
insert into Customer (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-03', '120')
insert into Customer (customer_id, name, visited_on, amount) values ('4', 'Khaled', '2019-01-04', '130')
insert into Customer (customer_id, name, visited_on, amount) values ('5', 'Winston', '2019-01-05', '110')
insert into Customer (customer_id, name, visited_on, amount) values ('6', 'Elvis', '2019-01-06', '140')
insert into Customer (customer_id, name, visited_on, amount) values ('7', 'Anna', '2019-01-07', '150')
insert into Customer (customer_id, name, visited_on, amount) values ('8', 'Maria', '2019-01-08', '80')
insert into Customer (customer_id, name, visited_on, amount) values ('9', 'Jaze', '2019-01-09', '110')
insert into Customer (customer_id, name, visited_on, amount) values ('1', 'Jhon', '2019-01-10', '130')
insert into Customer (customer_id, name, visited_on, amount) values ('3', 'Jade', '2019-01-10', '150')


SELECT * FROM Customer;

-- Solution
WITH day_sum AS (
	SELECT visited_on, SUM(amount) AS amount
	FROM Customer
	GROUP BY visited_on
)
, src AS (
	SELECT visited_on, amount
	, AVG(1.0*amount) OVER (ORDER BY visited_on ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS average_amount
	, COUNT(1) OVER (ORDER BY visited_on ASC ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS cnt
	FROM day_sum
)
SELECT visited_on, amount, CAST(average_amount AS DECIMAL(10,2)) AS average_amount FROM src
WHERE cnt = 7


-- Won't work in SQL Server
WITH src AS (
	SELECT visited_on, amount
	, AVG(1.0*amount) OVER (ORDER BY visited_on ASC RANGE BETWEEN 6 PRECEDING AND CURRENT ROW) AS average_amount
	, COUNT(1) OVER (ORDER BY visited_on ASC RANGE BETWEEN 6 PRECEDING AND CURRENT ROW) AS cnt
	FROM Customer
)
SELECT visited_on, amount, average_amount FROM src
WHERE cnt = 7;



