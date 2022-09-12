-- ANKIT BANSAL : https://www.youtube.com/watch?v=4MLVfsQEGl0

USE demo
GO

DROP TABLE IF EXISTS Spending
GO

Create table Spending (user_id int, spend_date date, platform varchar(20) CHECK (platform IN ('mobile', 'desktop')), amount int)
Truncate table Spending
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('1', '2019-07-01', 'desktop', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-01', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('2', '2019-07-02', 'mobile', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-01', 'desktop', '100')
insert into Spending (user_id, spend_date, platform, amount) values ('3', '2019-07-02', 'desktop', '100')

SELECT * FROM Spending
GO

WITH src AS (
SELECT spend_date, user_id, MAX(platform) AS platform, SUM(amount) AS amount
	FROM Spending
	GROUP BY spend_date, user_id 
	HAVING COUNT(DISTINCT platform) = 1
	UNION ALL
	SELECT spend_date, user_id, 'both' AS platform, SUM(amount) AS amount
	FROM Spending
	GROUP BY spend_date, user_id 
	HAVING COUNT(DISTINCT platform) = 2
	UNION ALL
	SELECT spend_date, NULL AS user_id, 'both' AS platform, 0 AS amount
	FROM Spending
)
SELECT spend_date, platform, SUM(amount) AS total_amount, COUNT(DISTINCT user_id) AS total_users
FROM src
GROUP BY spend_date, platform
ORDER BY spend_date, platform DESC

