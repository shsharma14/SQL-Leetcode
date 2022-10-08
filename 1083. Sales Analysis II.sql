USE demo
GO


DROP TABLE IF EXISTS Saless
DROP TABLE IF EXISTS Productss


Create table Productss (Productss_id int, Productss_name varchar(10), unit_price int)
Create table Saless (seller_id int, Productss_id int, buyer_id int, sale_date date, quantity int, price int)
Truncate table Productss
insert into Productss (Productss_id, Productss_name, unit_price) values ('1', 'S8', '1000')
insert into Productss (Productss_id, Productss_name, unit_price) values ('2', 'G4', '800')
insert into Productss (Productss_id, Productss_name, unit_price) values ('3', 'iPhone', '1400')
Truncate table Saless
insert into Saless (seller_id, Productss_id, buyer_id, sale_date, quantity, price) values ('1', '1', '1', '2019-01-21', '2', '2000')
insert into Saless (seller_id, Productss_id, buyer_id, sale_date, quantity, price) values ('1', '2', '2', '2019-02-17', '1', '800')
insert into Saless (seller_id, Productss_id, buyer_id, sale_date, quantity, price) values ('2', '1', '3', '2019-06-02', '1', '800')
insert into Saless (seller_id, Productss_id, buyer_id, sale_date, quantity, price) values ('3', '3', '3', '2019-05-13', '2', '2800')


SELECT * FROM Saless;
SELECT * FROM Productss;

----- Solution 1
WITH src AS (
	SELECT s.buyer_id, s.Productss_id, p.Productss_name,
	CASE WHEN p.Productss_name = 'S8' THEN 1 ELSE 0 END AS S8_binary,
	CASE WHEN p.Productss_name = 'iPhone' THEN 1 ELSE 0 END AS iPhone_binary
	FROM Saless s
	INNER JOIN Productss p on s.Productss_id = p.Productss_id
)
SELECT buyer_id FROM src
GROUP BY buyer_id
HAVING SUM(S8_binary) > 0 AND SUM(iPhone_binary) = 0
GO

-- We can remove subquery 

SELECT s.buyer_id
FROM Saless s
INNER JOIN Productss p on s.Productss_id = p.Productss_id
GROUP BY s.buyer_id
HAVING SUM(CASE WHEN p.Productss_name = 'S8' THEN 1 ELSE 0 END) > 0 -- A buyer buys atleast 1 S8
	AND 
	SUM(CASE WHEN p.Productss_name = 'iPhone' THEN 1 ELSE 0 END) = 0 -- A buyer does not buy an iphone.


------ Solution 2
-- A EXCEPT B will return rows from A (people who bought S8) that are not in B (people who bought iPhone).
-- The output will be all buyers who bought an S8 but did not buy iPhone.
SELECT buyer_id
FROM Saless INNER JOIN Productss ON Saless.Productss_id = Productss.Productss_id
WHERE Productss.Productss_name = 'S8'
EXCEPT
SELECT buyer_id
FROM Saless INNER JOIN Productss ON Saless.Productss_id = Productss.Productss_id
WHERE Productss.Productss_name = 'iPhone'