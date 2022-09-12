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

----

SELECT
CASE WHEN id = LAST_VALUE(id) OVER (ORDER BY id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) THEN id
	 WHEN id%2 = 0 THEN id - 1 
	 WHEN id%2 = 1 THEN id + 1	
	 END AS id,
student
FROM Seat
ORDER BY id

-------
SELECT
CASE WHEN id = (SELECT MAX(id) FROM Seat) THEN id
	 WHEN id%2 = 0 THEN id - 1 
	 WHEN id%2 = 1 THEN id + 1	
	 END AS id,
student
FROM Seat

SELECT id, CASE WHEN id % 2 <> 0 THEN LEAD(student,1,student)OVER(ORDER BY id)
                WHEN id % 2 = 0 THEN LAG(student)OVER(ORDER BY id)
            END AS student
FROM Seat