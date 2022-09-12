USE demo
GO

DROP TABLE IF EXISTS Activity
GO


Create table Activity (player_id int, device_id int, event_date date, games_played int)
Truncate table Activity
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-01', '5')
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '2', '2016-03-02', '6')
insert into Activity (player_id, device_id, event_date, games_played) values ('1', '3', '2016-03-02', '2')
insert into Activity (player_id, device_id, event_date, games_played) values ('2', '3', '2017-06-25', '1')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '1', '2016-03-02', '0')
insert into Activity (player_id, device_id, event_date, games_played) values ('3', '4', '2018-07-03', '5')

SELECT * FROM Activity
GO

WITH src AS (
    SELECT player_id, event_date,
    FIRST_VALUE(event_date) OVER (PARTITION BY player_id ORDER BY event_date) AS first_login
    FROM Activity
), t1 AS (
	SELECT DISTINCT player_id, event_date, first_login 
	FROM src
)
SELECT * FROM 

