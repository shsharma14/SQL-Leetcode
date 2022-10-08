USE demo
GO

DROP TABLE IF EXISTS Product
DROP TABLE IF EXISTS lc_Sales

Create table Product (product_id int, product_name varchar(30))
Create table lc_Sales (product_id int, period_start date, period_end date, average_daily_lc_Sales int)
Truncate table Product
insert into Product (product_id, product_name) values ('1', 'LC Phone ')
insert into Product (product_id, product_name) values ('2', 'LC T-Shirt')
insert into Product (product_id, product_name) values ('3', 'LC Keychain')
Truncate table lc_Sales
insert into lc_Sales (product_id, period_start, period_end, average_daily_lc_Sales) values ('1', '2019-01-25', '2019-02-28', '100')
insert into lc_Sales (product_id, period_start, period_end, average_daily_lc_Sales) values ('2', '2018-12-01', '2020-01-01', '10')
insert into lc_Sales (product_id, period_start, period_end, average_daily_lc_Sales) values ('3', '2019-12-01', '2020-01-31', '1')

SELECT * FROM Product
SELECT * FROM lc_Sales;



WITH src AS (
	SELECT *
	, YEAR(period_start) AS start_year 
	, YEAR(period_end) AS end_year 
	, DATEDIFF(DAY, period_start, period_end) AS date_diff
	FROM lc_Sales
) 
SELECT * FROM src




