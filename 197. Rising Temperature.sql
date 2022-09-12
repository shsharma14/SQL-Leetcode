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



-- Get information from different row into the same row and compare them - SELF JOIN. 
SELECT w2.id FROM 
Weather w1 
JOIN Weather w2 on DATEDIFF(DAY,w1.recordDate, w2.recordDate) = 1 and w2.temperature > w1.temperature
GO


-- Can't use this solution as the question requires finding ids with temperature greater than previous day. If previous day data is not there
-- skip that id also. Above, we don't have data for 4th. So, we can't say ID 4 has temperature greater than previous day. 
WITH src AS (
    SELECT id, recordDate, temperature,
    LAG(temperature) OVER (ORDER BY recordDate) AS prev_day_temp
    FROM Weather
)
SELECT id FROM src
WHERE temperature > prev_day_temp