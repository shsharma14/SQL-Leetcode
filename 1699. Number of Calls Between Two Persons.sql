USE demo
GO


DROP TABLE IF EXISTS Calls


Create table Calls (from_id int, to_id int, duration int)
--Truncate table Calls
insert into Calls (from_id, to_id, duration) values ('1', '2', '59')
insert into Calls (from_id, to_id, duration) values ('2', '1', '11')
insert into Calls (from_id, to_id, duration) values ('1', '3', '20')
insert into Calls (from_id, to_id, duration) values ('3', '4', '100')
insert into Calls (from_id, to_id, duration) values ('3', '4', '200')
insert into Calls (from_id, to_id, duration) values ('3', '4', '200')
insert into Calls (from_id, to_id, duration) values ('4', '3', '499')


SELECT * FROM Calls;



WITH final_data AS (
	SELECT 
	CASE WHEN from_id < to_id THEN from_id ELSE to_id END AS person1
	, CASE WHEN from_id > to_id THEN from_id ELSE to_id END AS person2
	, duration
	FROM Calls
)
SELECT person1, person2
, COUNT(1) AS call_count
, SUM(duration) AS total_duration
FROM final_data
GROUP BY person1, person2



