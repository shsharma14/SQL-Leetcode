USE demo
GO

DROP TABLE IF EXISTS Activity
GO


Create table Activity (player_id int, device_id int, event_date date, games_played int)
Truncate table Activity
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5')
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6')
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5')

SELECT * FROM Activity
GO


-- you need to count the number of players that logged in for at least two consecutive days starting from their FIRST LOGIN DATE, 
-- then divide that number by the total number of players.

-- Solution
WITH src AS (
	SELECT *
	, FIRST_VALUE(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS first_login_date
	, LEAD(event_date,1,event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS next_event_date
	FROM Activity
)
SELECT CAST(1.0*COUNT(DISTINCT player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity) AS DECIMAL(10,2)) AS fraction
FROM src 
WHERE DATEDIFF(DAY, first_login_date, next_event_date) = 1




-- Using JOIN
SELECT CAST(1.0*COUNT(DISTINCT t1.player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity) AS DECIMAL(10,2)) AS fraction
FROM 
(SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id) t1
INNER JOIN Activity t2 ON DATEDIFF(DAY, t1.first_login, t2.event_date) = 1 AND t1.player_id = t2.player_id




