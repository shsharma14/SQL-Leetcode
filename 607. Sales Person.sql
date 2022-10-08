USE demo
GO

DROP TABLE IF EXISTS lc_SalesPerson
DROP TABLE IF EXISTS lc_Company
DROP TABLE IF EXISTS lc_Orders


Create table lc_SalesPerson (sales_id int, name varchar(255), salary int, commission_rate int, hire_date date)
Create table lc_Company (com_id int, name varchar(255), city varchar(255))
Create table lc_Orders (order_id int, order_date date, com_id int, sales_id int, amount int)
Truncate table lc_SalesPerson

insert into lc_SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('1', 'John', '100000', '6', '4/1/2006')
insert into lc_SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('2', 'Amy', '12000', '5', '5/1/2010')
insert into lc_SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('3', 'Mark', '65000', '12', '12/25/2008')
insert into lc_SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('4', 'Pam', '25000', '25', '1/1/2005')
insert into lc_SalesPerson (sales_id, name, salary, commission_rate, hire_date) values ('5', 'Alex', '5000', '10', '2/3/2007')
Truncate table lc_Company

insert into lc_Company (com_id, name, city) values ('1', 'RED', 'Boston')
insert into lc_Company (com_id, name, city) values ('2', 'ORANGE', 'New York')
insert into lc_Company (com_id, name, city) values ('3', 'YELLOW', 'Boston')
insert into lc_Company (com_id, name, city) values ('4', 'GREEN', 'Austin')
Truncate table lc_Orders

insert into lc_Orders (order_id, order_date, com_id, sales_id, amount) values ('1', '1/1/2014', '3', '4', '10000')
insert into lc_Orders (order_id, order_date, com_id, sales_id, amount) values ('2', '2/1/2014', '4', '5', '5000')
insert into lc_Orders (order_id, order_date, com_id, sales_id, amount) values ('3', '3/1/2014', '1', '1', '50000')
insert into lc_Orders (order_id, order_date, com_id, sales_id, amount) values ('4', '4/1/2014', '1', '4', '25000')

SELECT * FROM lc_Company;
SELECT * FROM lc_Orders;
SELECT * FROM lc_SalesPerson;



SELECT * FROM lc_SalesPerson s
LEFT JOIN lc_Orders o ON o.sales_id = s.sales_id AND o.amount = 10000






SELECT * FROM lc_SalesPerson s
LEFT JOIN (SELECT * FROM lc_Orders WHERE amount = 10000) o ON o.sales_id = s.sales_id 