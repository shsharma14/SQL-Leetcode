USE demo
GO

DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Exam;


Create table Student (student_id int, student_name varchar(30))
Create table Exam (exam_id int, student_id int, score int)
Truncate table Student
insert into Student (student_id, student_name) values ('1', 'Daniel')
insert into Student (student_id, student_name) values ('2', 'Jade')
insert into Student (student_id, student_name) values ('3', 'Stella')
insert into Student (student_id, student_name) values ('4', 'Jonathan')
insert into Student (student_id, student_name) values ('5', 'Will')
Truncate table Exam
insert into Exam (exam_id, student_id, score) values ('10', '1', '70')
insert into Exam (exam_id, student_id, score) values ('10', '2', '80')
insert into Exam (exam_id, student_id, score) values ('10', '3', '90')
insert into Exam (exam_id, student_id, score) values ('20', '1', '80')
insert into Exam (exam_id, student_id, score) values ('30', '1', '70')
insert into Exam (exam_id, student_id, score) values ('30', '3', '80')
insert into Exam (exam_id, student_id, score) values ('30', '4', '90')
insert into Exam (exam_id, student_id, score) values ('40', '1', '60')
insert into Exam (exam_id, student_id, score) values ('40', '2', '70')
insert into Exam (exam_id, student_id, score) values ('40', '4', '80')

SELECT * FROM Student;
SELECT * FROM Exam;


-- Solution 1 (using EXCEPT)
WITH src AS (
    SELECT s.student_id, s.student_name
    , RANK() OVER (PARTITION BY e.exam_id ORDER BY e.score ASC) AS rn1
    , RANK() OVER (PARTITION BY e.exam_id ORDER BY e.score DESC) AS rn2
    FROM Student s 
    INNER JOIN Exam e ON s.student_id = e.student_id
)
SELECT S.student_id, student_name
FROM Student s 
INNER JOIN Exam e ON s.student_id = e.student_id
EXCEPT
SELECT student_id, student_name
FROM src 
WHERE rn1 = 1 OR rn2 = 1 -- student_id NOT IN (SELECT student_id FROM src WHERE rn1 = 1 OR rn2 = 1)
GROUP BY student_id, student_name
ORDER BY student_id;


-- Solution 2 (using NOT IN)
 WITH src AS (
     SELECT s.student_id, s.student_name
     , RANK() OVER (PARTITION BY e.exam_id ORDER BY e.score ASC) AS rn1
     , RANK() OVER (PARTITION BY e.exam_id ORDER BY e.score DESC) AS rn2
     FROM Student s 
     INNER JOIN Exam e ON s.student_id = e.student_id
 )
 SELECT student_id, student_name
 FROM src 
 WHERE student_id NOT IN (SELECT student_id FROM src WHERE rn1 = 1 OR rn2 = 1)
 GROUP BY student_id, student_name
 ORDER BY student_id;


 -- Solution 3 (Using JOINS)
 WITH min_max_score AS (
	 SELECT exam_id, MIN(score) AS min_score, MAX(score) AS max_score
	 FROM Exam
	 GROUP BY exam_id
 )
 , students_having_min_max_score AS (
	 SELECT Exam.student_id
	 FROM Exam INNER JOIN min_max_score m 
	 ON Exam.exam_id = m.exam_id AND (Exam.score = m.max_score OR Exam.score = m.min_score)
 )
 SELECT DISTINCT s.student_id, s.student_name
 FROM Student s
 INNER JOIN Exam e ON s.student_id = e.student_id
 WHERE s.student_id NOT IN (SELECT student_id FROM students_having_min_max_score)