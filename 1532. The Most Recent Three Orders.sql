USE demo
GO

DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Orders;


Create table Customers (customer_id int, name varchar(10))
Create table Orders (order_id int, order_date date, customer_id int, cost int)
Truncate table Customers
insert into Customers (customer_id, name) values ('1', 'Winston')
insert into Customers (customer_id, name) values ('2', 'Jonathan')
insert into Customers (customer_id, name) values ('3', 'Annabelle')
insert into Customers (customer_id, name) values ('4', 'Marwan')
insert into Customers (customer_id, name) values ('5', 'Khaled')
Truncate table Orders
insert into Orders (order_id, order_date, customer_id, cost) values ('1', '2020-07-31', '1', '30')
insert into Orders (order_id, order_date, customer_id, cost) values ('2', '2020-7-30', '2', '40')
insert into Orders (order_id, order_date, customer_id, cost) values ('3', '2020-07-31', '3', '70')
insert into Orders (order_id, order_date, customer_id, cost) values ('4', '2020-07-29', '4', '100')
insert into Orders (order_id, order_date, customer_id, cost) values ('5', '2020-06-10', '1', '1010')
insert into Orders (order_id, order_date, customer_id, cost) values ('6', '2020-08-01', '2', '102')
insert into Orders (order_id, order_date, customer_id, cost) values ('7', '2020-08-01', '3', '111')
insert into Orders (order_id, order_date, customer_id, cost) values ('8', '2020-08-03', '1', '99')
insert into Orders (order_id, order_date, customer_id, cost) values ('9', '2020-08-07', '2', '32')
insert into Orders (order_id, order_date, customer_id, cost) values ('10', '2020-07-15', '1', '2')

SELECT * FROM Customers;
SELECT * FROM Orders;

-- Solution
WITH final_data AS (
	SELECT c.customer_id, c.name, o.order_id, o.order_date
	, ROW_NUMBER() OVER (PARTITION BY c.customer_id ORDER BY o.order_date DESC) AS rn
	FROM Customers c 
	INNER JOIN Orders o ON c.customer_id = o.customer_id
)
SELECT name, customer_id, order_id, order_date 
FROM final_data
WHERE rn <= 3
ORDER BY name ASC, customer_id ASC, order_date DESC

