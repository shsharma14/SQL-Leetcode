Use Demo
GO

DROP TABLE IF EXISTS Scores;


Create table Scores (id int, score DECIMAL(3,2))
Truncate table Scores
insert into Scores (id, score) values ('1', '3.5')
insert into Scores (id, score) values ('2', '3.65')
insert into Scores (id, score) values ('3', '4.0')
insert into Scores (id, score) values ('4', '3.85')
insert into Scores (id, score) values ('5', '4.0')
insert into Scores (id, score) values ('6', '3.65')


SELECT * FROM Scores;

-- Solution

SELECT score,
DENSE_RANK() OVER (ORDER BY score DESC) AS rnk
FROM Scores