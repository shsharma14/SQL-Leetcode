USE demo
GO


DROP TABLE IF EXISTS Purchases;

Create table Purchases (purchase_id int, user_id int, purchase_date date)
Truncate table Purchases
insert into Purchases (purchase_id, user_id, purchase_date) values ('4', '2', '2022-03-13')
insert into Purchases (purchase_id, user_id, purchase_date) values ('1', '5', '2022-02-11')
insert into Purchases (purchase_id, user_id, purchase_date) values ('3', '7', '2022-06-19')
insert into Purchases (purchase_id, user_id, purchase_date) values ('6', '2', '2022-03-20')
insert into Purchases (purchase_id, user_id, purchase_date) values ('5', '7', '2022-06-19')
insert into Purchases (purchase_id, user_id, purchase_date) values ('2', '2', '2022-06-08')


insert into Purchases (purchase_id, user_id, purchase_date) values ('7', '5', '2022-05-09')
insert into Purchases (purchase_id, user_id, purchase_date) values ('5', '9', '2022-04-04')
insert into Purchases (purchase_id, user_id, purchase_date) values ('2', '5', '2022-12-13')
insert into Purchases (purchase_id, user_id, purchase_date) values ('8', '1', '2022-10-30')
insert into Purchases (purchase_id, user_id, purchase_date) values ('9', '1', '2022-09-26')
insert into Purchases (purchase_id, user_id, purchase_date) values ('3', '9', '2022-09-06')
insert into Purchases (purchase_id, user_id, purchase_date) values ('1', '1', '2022-09-06')
insert into Purchases (purchase_id, user_id, purchase_date) values ('4', '1', '2022-03-12')
insert into Purchases (purchase_id, user_id, purchase_date) values ('6', '5', '2022-11-14')


SELECT * FROM Purchases;


SELECT p1.user_id
FROM Purchases p1
INNER JOIN Purchases p2 ON p1.user_id = p2.user_id AND DATEDIFF(DAY, p1.purchase_date, p2.purchase_date) BETWEEN 0 AND 7 AND p1.purchase_id <> p2.purchase_id
GROUP BY p1.user_id
HAVING COUNT(1) >=1
ORDER BY user_id