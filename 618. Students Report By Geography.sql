USE demo
GO

DROP TABLE IF EXISTS Student;

Create table Student (name varchar(50), continent varchar(7))
Truncate table Student
insert into Student (name, continent) values ('Jane', 'America')
insert into Student (name, continent) values ('Pascal', 'Europe')
insert into Student (name, continent) values ('Xi', 'Asia')
insert into Student (name, continent) values ('Jack', 'America')

SELECT * FROM Student;

-- 

WITH ranked_data AS (
	SELECT name, continent,
	ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS rn
	FROM Student
)
SELECT 
MAX(CASE WHEN continent = 'America' THEN name ELSE NULL END) AS 'America'
, MAX(CASE WHEN continent = 'Asia' THEN name ELSE NULL END) AS 'Asia'
, MAX(CASE WHEN continent = 'Europe' THEN name ELSE NULL END) AS 'Europe'
FROM ranked_data
GROUP BY rn


-- Solution 2 
SELECT America, Asia, Europe
FROM
	(SELECT name, continent,
	ROW_NUMBER() OVER (PARTITION BY continent ORDER BY name) AS rn
	FROM Student) A PIVOT (
	MIN(name) FOR continent IN (America, Asia, Europe)
) AS pivot_tbl
