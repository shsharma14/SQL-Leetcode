USE demo
GO

DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Logins;

Create table Accounts (id int, name varchar(10))
Create table Logins (id int, login_date date)

-- Test case 1
Truncate table Accounts
insert into Accounts (id, name) values ('1', 'Winston')
insert into Accounts (id, name) values ('7', 'Jonathan')
Truncate table Logins
insert into Logins (id, login_date) values ('7', '2020-05-30')
insert into Logins (id, login_date) values ('1', '2020-05-30')
insert into Logins (id, login_date) values ('7', '2020-05-31')
insert into Logins (id, login_date) values ('7', '2020-06-01')
insert into Logins (id, login_date) values ('7', '2020-06-02')
insert into Logins (id, login_date) values ('7', '2020-06-02')
insert into Logins (id, login_date) values ('7', '2020-06-03')
insert into Logins (id, login_date) values ('1', '2020-06-07')
insert into Logins (id, login_date) values ('7', '2020-06-10')


-- Test case 2
Truncate table Accounts
insert into Accounts (id, name) values ('7', 'Jonathan')

Truncate table Logins
insert into Logins (id, login_date) values ('7', '2020-06-28')
insert into Logins (id, login_date) values ('7', '2020-06-27')
insert into Logins (id, login_date) values ('7', '2020-06-26')
insert into Logins (id, login_date) values ('7', '2020-07-02')
insert into Logins (id, login_date) values ('7', '2020-07-01')
insert into Logins (id, login_date) values ('7', '2020-06-29')
insert into Logins (id, login_date) values ('7', '2020-07-01')
insert into Logins (id, login_date) values ('7', '2020-06-28')
insert into Logins (id, login_date) values ('7', '2020-06-27')
insert into Logins (id, login_date) values ('7', '2020-07-02')
insert into Logins (id, login_date) values ('7', '2020-06-29')
insert into Logins (id, login_date) values ('7', '2020-06-26')
insert into Logins (id, login_date) values ('7', '2020-07-02')
insert into Logins (id, login_date) values ('7', '2020-06-28')
insert into Logins (id, login_date) values ('7', '2020-07-02')
insert into Logins (id, login_date) values ('7', '2020-06-30')
insert into Logins (id, login_date) values ('7', '2020-07-03')
insert into Logins (id, login_date) values ('7', '2020-06-29')
insert into Logins (id, login_date) values ('7', '2020-07-03')
insert into Logins (id, login_date) values ('7', '2020-07-02')
insert into Logins (id, login_date) values ('7', '2020-06-30')
insert into Logins (id, login_date) values ('7', '2020-07-04')
insert into Logins (id, login_date) values ('7', '2020-06-28')
GO

SELECT *
	FROM Accounts INNER JOIN Logins 
	ON Accounts.id = Logins.id;


-- solution 1
-- difference of row_num, getting same date and grouping by date
WITH t1 AS (
	SELECT Accounts.id, Accounts.name, Logins.login_date, ROW_NUMBER() OVER (PARTITION BY Accounts.id ORDER BY Accounts.id, login_date) AS rn
	,DATEADD(DAY,-CAST(ROW_NUMBER() OVER (PARTITION BY Accounts.id ORDER BY Accounts.id, login_date) AS INT),Logins.login_date) AS diff
	FROM Accounts INNER JOIN Logins 
	ON Accounts.id = Logins.id
	GROUP BY Accounts.id, Accounts.name, Logins.login_date -- need to remove cases where user logged in twice on same day
), t2 AS (
	SELECT id, name, login_date, rn,
	COUNT(1) OVER (PARTITION BY id, diff) AS group_count
	FROM t1
)
SELECT DISTINCT id, name FROM t2
WHERE group_count >= 5
GO





-- Can use self-join also