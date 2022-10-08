USE demo
GO

DROP TABLE IF EXISTS Weather
GO


Create table Weather (id int, recordDate date, temperature int)
Truncate table Weather
insert into Weather (id, recordDate, temperature) values ('1', '2015-01-01', '10')
insert into Weather (id, recordDate, temperature) values ('2', '2015-01-02', '25')
insert into Weather (id, recordDate, temperature) values ('3', '2015-01-03', '20')
insert into Weather (id, recordDate, temperature) values ('4', '2015-01-05', '30')

SELECT * FROM Weather
GO



-- Solution 1: Get information from different row into the same row and compare them - SELF JOIN. 
SELECT w2.id 
FROM Weather w1 
INNER JOIN Weather w2 on DATEDIFF(DAY,w1.recordDate, w2.recordDate) = 1 and w2.temperature > w1.temperature
GO


-- Solution 2: Using LAG
-- We can use LAG and we do not need to care about the NULL in the first row. 
WITH weather_data AS (
    SELECT id, recordDate, temperature,
    LAG(temperature) OVER (ORDER BY recordDate) AS prev_day_temp,
	LAG(recordDate) OVER (ORDER BY recordDate) AS prev_day
    FROM Weather
)
SELECT id FROM weather_data
WHERE temperature > prev_day_temp AND DATEDIFF(DAY, prev_day, recordDate) = 1

