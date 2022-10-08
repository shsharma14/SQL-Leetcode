USE demo
GO

DROP TABLE IF EXISTS Seat
GO

Create table Seat (id int, student varchar(255))
Truncate table Seat
insert into Seat (id, student) values ('1', 'Abbot')
insert into Seat (id, student) values ('2', 'Doris')
insert into Seat (id, student) values ('3', 'Emerson')
insert into Seat (id, student) values ('4', 'Green')
insert into Seat (id, student) values ('5', 'Jeames')

SELECT * FROM Seat


SELECT id, student
, LEAD(student,1,student) OVER (ORDER BY id) AS next_student
, LEAD(student,1,'No rows after this') OVER (ORDER BY id) AS next_student_default
FROM Seat;

---- Solution

SELECT id
, CASE WHEN id % 2 <> 0 THEN LEAD(student,1,student) OVER (ORDER BY id) -- odd ID
       WHEN id % 2 = 0 THEN LAG(student) OVER (ORDER BY id) -- even ID
  END AS student
FROM Seat