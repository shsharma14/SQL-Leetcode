USE demo
GO

DROP TABLE IF EXISTS Contests
DROP TABLE IF EXISTS Users


Create table Contests (contest_id int, gold_medal int, silver_medal int, bronze_medal int)
Create table Users (user_id int, mail varchar(50), name varchar(30))
Truncate table Contests
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('190', '1', '5', '2')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('191', '2', '3', '5')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('192', '5', '2', '3')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('193', '1', '3', '5')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('194', '4', '5', '2')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('195', '4', '2', '1')
insert into Contests (contest_id, gold_medal, silver_medal, bronze_medal) values ('196', '1', '5', '2')
Truncate table Users
insert into Users (user_id, mail, name) values ('1', 'sarah@leetcode.com', 'Sarah')
insert into Users (user_id, mail, name) values ('2', 'bob@leetcode.com', 'Bob')
insert into Users (user_id, mail, name) values ('3', 'alice@leetcode.com', 'Alice')
insert into Users (user_id, mail, name) values ('4', 'hercy@leetcode.com', 'Hercy')
insert into Users (user_id, mail, name) values ('5', 'quarz@leetcode.com', 'Quarz');


SELECT * FROM Users;
SELECT * FROM Contests;


WITH unpivot_data AS (
	--UNPIVOT Contest Table:
	SELECT * FROM Contests
	UNPIVOT (
		user_id for medal_type IN (gold_medal, silver_medal, bronze_medal)
	) AS tbl
)
, three_gold_medals AS (
	SELECT user_id
	FROM unpivot_data
	WHERE medal_type = 'gold_medal'
	GROUP BY user_id
	HAVING COUNT(1) >= 3
) --SELECT * FROM three_gold_medals
, consecutive_contests AS (
	SELECT user_id, contest_id,
	LEAD(contest_id,2) OVER (PARTITION BY user_id ORDER BY contest_id ASC) AS lead_two_contest
	FROM unpivot_data
)  --SELECT * FROM consecutive_contests
SELECT name, mail FROM 
(SELECT user_id 
FROM three_gold_medals
UNION
SELECT user_id 
FROM consecutive_contests
GROUP BY user_id
HAVING SUM(CASE WHEN lead_two_contest - contest_id = 2 THEN 1 ELSE 0 END) >= 1) A
INNER JOIN Users ON A.user_id = Users.user_id