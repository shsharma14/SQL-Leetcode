-- Write an SQL query to report the number of grand slam tournaments won by each player. Do not include the players who did not win any tournament.


--Output: 
--+-----------+-------------+-------------------+
--| player_id | player_name | grand_slams_count |
--+-----------+-------------+-------------------+
--| 2         | Federer     | 5                 |
--| 1         | Nadal       | 7                 |
--+-----------+-------------+-------------------+



USE demo
GO

DROP TABLE IF EXISTS tennis;
DROP TABLE IF EXISTS Championships

Create table tennis (player_id int, player_name varchar(20))
Create table Championships (year int, Wimbledon int, Fr_open int, US_open int, Au_open int)
Truncate table tennis
insert into tennis (player_id, player_name) values ('1', 'Nadal')
insert into tennis (player_id, player_name) values ('2', 'Federer')
insert into tennis (player_id, player_name) values ('3', 'Novak')
Truncate table Championships
insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2018', '1', '1', '1', '1')
insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2019', '1', '1', '2', '2')
insert into Championships (year, Wimbledon, Fr_open, US_open, Au_open) values ('2020', '2', '1', '2', '2')


SELECT * FROM tennis;
select * from Championships;


WITH src AS (
	select * from Championships
	UNPIVOT (
		player_id for tournament IN (Wimbledon, Fr_open, US_open, Au_open)
	) AS pivot_tbl
)
SELECT src.player_id, tennis.player_name, COUNT(1) AS grand_slams_count
FROM src
INNER JOIN tennis ON src.player_id = tennis.player_id
GROUP BY src.player_id, tennis.player_name

