USE demo
GO

DROP TABLE IF EXISTS Activities;


Create table Activities (sell_date date, product varchar(20))
Truncate table Activities
insert into Activities (sell_date, product) values ('2020-05-30', 'Headphone')
insert into Activities (sell_date, product) values ('2020-06-01', 'Pencil')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'Basketball')
insert into Activities (sell_date, product) values ('2020-06-01', 'Bible')
insert into Activities (sell_date, product) values ('2020-06-02', 'Mask')
insert into Activities (sell_date, product) values ('2020-05-30', 'T-Shirt')

SELECT * FROM Activities;

SELECT STRING_AGG(product, ', ') AS aggregated_products
FROM Activities;

SELECT STRING_AGG(product, ', ') 
WITHIN GROUP (ORDER BY product) AS aggregated_products
FROM Activities;

-- Solution 
SELECT sell_date
, COUNT(DISTINCT product) AS num_sold
, STRING_AGG(product, ', ') WITHIN GROUP (ORDER BY product) AS products
FROM (SELECT DISTINCT Product, sell_date FROM Activities) tbl
GROUP BY sell_date