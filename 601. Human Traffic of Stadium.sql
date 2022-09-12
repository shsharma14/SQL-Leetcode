-- This question is same as techTFQ's weather question (From the weather table, fetch all the records when London 
--had extremely cold temperature for 3 consecutive days or more.)

USE demo
GO

DROP TABLE IF EXISTS Stadium
GO

Create table Stadium (id int, visit_date DATE NULL, people int)
Truncate table Stadium
insert into Stadium (id, visit_date, people) values ('1', '2017-01-01', '10')
insert into Stadium (id, visit_date, people) values ('2', '2017-01-02', '109')
insert into Stadium (id, visit_date, people) values ('3', '2017-01-03', '150')
insert into Stadium (id, visit_date, people) values ('4', '2017-01-04', '99')
insert into Stadium (id, visit_date, people) values ('5', '2017-01-05', '145')
insert into Stadium (id, visit_date, people) values ('6', '2017-01-06', '1455')
insert into Stadium (id, visit_date, people) values ('7', '2017-01-07', '199')
insert into Stadium (id, visit_date, people) values ('8', '2017-01-09', '188')

SELECT * FROM Stadium
GO


WITH t1 AS (
	SELECT id, visit_date, people,
	id - ROW_NUMBER() OVER (ORDER BY id) AS rn
	FROM Stadium
	WHERE people > 99
),
t2 AS (
	SELECT id, visit_date, people,
	COUNT(1) OVER (PARTITION BY rn) AS cnt
	FROM t1
)
SELECT id, visit_date, people
FROM t2 
WHERE cnt >=3