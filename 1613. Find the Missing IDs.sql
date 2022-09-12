USE demo
GO

DROP TABLE IF EXISTS Customer

Create table Customer (customer_id int, customer_name varchar(20))
Truncate table Customers
insert into Customer (customer_id, customer_name) values ('1', 'Alice')
insert into Customer (customer_id, customer_name) values ('4', 'Bob')
insert into Customer (customer_id, customer_name) values ('5', 'Charlie')

SELECT * FROM Customer;

WITH max_cte AS (
	SELECT MAX(customer_id) AS maximum FROM Customer
),
src AS (
	SELECT 1 AS id FROM Customer
	UNION ALL
	SELECT id+1 FROM src A join max_cte B
	ON id < maximum  
)
SELECT DISTINCT id FROM src
WHERE id NOT IN (SELECT customer_id FROM Customer);



