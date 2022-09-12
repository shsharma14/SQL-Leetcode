-- Yet to be solved. Below solutions are wrong. 


USE demo
GO
DROP TABLE IF EXISTS Teams
DROP TABLE IF EXISTS Matches


Create table Teams (team_id int, team_name varchar(20))
Create table Matches (home_team_id int, away_team_id int, home_team_goals int, away_team_goals int)
Truncate table Teams
insert into Teams (team_id, team_name) values ('1', 'Ajax')
insert into Teams (team_id, team_name) values ('4', 'Dortmund')
insert into Teams (team_id, team_name) values ('6', 'Arsenal')
Truncate table Matches
insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals) values ('1', '4', '0', '1')
insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals) values ('1', '6', '3', '3')
insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals) values ('4', '1', '5', '2')
insert into Matches (home_team_id, away_team_id, home_team_goals, away_team_goals) values ('6', '1', '0', '0')


SELECT * FROM Teams
SELECT * FROM Matches
GO


WITH N AS (
	SELECT home_team_id AS team_id, home_team_goals AS home, away_team_goals AS away
	FROM matches
	UNION ALL
	SELECT away_team_id AS team_id, home_team_goals AS home, away_team_goals AS away
	FROM matches	
)
SELECT T.team_name,COUNT(N.team_id) AS matches_played,SUM(CASE WHEN N.home>N.away THEN 3 WHEN N.home<N.away THEN 0 ELSE 1 END) AS points,SUM(N.home) AS goal_for,SUM(N.away) AS goal_against,SUM(N.home)-SUM(N.away) AS goal_diff
FROM Teams AS T
JOIN N ON N.team_id=T.team_id
GROUP BY T.team_name
ORDER BY points DESC,goal_diff DESC,team_name ASC

WITH final_data AS (
	SELECT home_team_id AS team_id, home_team_goals AS home, away_team_goals AS away
	FROM matches
	UNION ALL
	SELECT away_team_id AS team_id, home_team_goals AS home, away_team_goals AS away
	FROM matches	
)
SELECT * FROM final_data


----- First Thought
--WITH winner_table AS (
--	SELECT home_team_id, away_team_id, home_team_goals, away_team_goals,
--	CASE WHEN home_team_goals > away_team_goals THEN home_team_id 
--		 WHEN home_team_goals < away_team_goals THEN away_team_id
--		 ELSE 0 
--	END AS Winner
--	FROM Matches
--), 
--t2 AS (
--	SELECT home_team_id AS team_id, COUNT(home_team_id) AS matches_played
--	FROM Matches
--	GROUP BY home_team_id
--	UNION ALL
--	SELECT away_team_id, COUNT(away_team_id)
--	FROM Matches
--	GROUP BY away_team_id
--), 
--t3 AS (
--	SELECT team_id, SUM(matches_played) AS matches_played
--	FROM t2
--	GROUP BY team_id
--)
--SELECT Teams.team_name, matches_played, winner_table.*
--FROM Teams JOIN t3 ON t3.team_id = Teams.team_id
--JOIN winner_table ON t3.team_id = winner_table.home_team_id OR t3.team_id = winner_table.away_team_id