USE demo
GO

DROP TABLE IF EXISTS Queue;


Create table Queue (person_id int, person_name varchar(30), weight int, turn int)
Truncate table Queue
insert into Queue (person_id, person_name, weight, turn) values ('5', 'Alice', '250', '1')
insert into Queue (person_id, person_name, weight, turn) values ('4', 'Bob', '175', '5')
insert into Queue (person_id, person_name, weight, turn) values ('3', 'Alex', '350', '2')
insert into Queue (person_id, person_name, weight, turn) values ('6', 'John Cena', '400', '3')
insert into Queue (person_id, person_name, weight, turn) values ('1', 'Winston', '500', '6')
insert into Queue (person_id, person_name, weight, turn) values ('2', 'Marie', '200', '4')

SELECT * FROM Queue;

WITH src AS (
	SELECT person_id, person_name, turn, weight
	, SUM(weight) OVER (ORDER BY turn ASC) AS running_sum
	FROM Queue 
)
SELECT person_name FROM src
WHERE running_sum = (SELECT MAX(running_sum) FROM src WHERE running_sum <= 1000);

