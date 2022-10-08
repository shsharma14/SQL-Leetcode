USE demo
GO

DROP TABLE IF EXISTS Cinema
GO


Create table Cinema (seat_id int primary key, free varchar(1))
Truncate table Cinema
insert into Cinema (seat_id, free) values ('1', '1')
insert into Cinema (seat_id, free) values ('2', '0')
insert into Cinema (seat_id, free) values ('3', '1')
insert into Cinema (seat_id, free) values ('4', '1')
insert into Cinema (seat_id, free) values ('5', '1')
insert into Cinema (seat_id, free) values ('6', '0')
insert into Cinema (seat_id, free) values ('7', '0')
insert into Cinema (seat_id, free) values ('8', '1')
insert into Cinema (seat_id, free) values ('9', '1')

SELECT * FROM Cinema;

-- Solution
WITH seat_data_groups AS (
	SELECT 
	seat_id,
	seat_id - ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS diff
	FROM Cinema
	WHERE free = 1
),
consecutive_seat_counts AS (
	SELECT seat_id, diff
	, COUNT(seat_id) OVER (PARTITION BY diff) AS cnt
	FROM seat_data_groups
)
SELECT seat_id FROM consecutive_seat_counts
WHERE cnt > 1





---- ANKIT BANSAL video (Problem with a twist)
-- https://www.youtube.com/watch?v=e4IILSHtKl4&t=13s
-- There are 3 rows in a movie hall with 10 seats. 
-- find 4 consecutive seats.

DROP TABLE IF EXISTS movie;

create table movie(
seat varchar(50),occupancy int
);
insert into movie values('a1',1),('a2',1),('a3',0),('a4',0),('a5',0),('a6',0),('a7',1),('a8',1),('a9',0),('a10',0),
('b1',0),('b2',0),('b3',0),('b4',1),('b5',1),('b6',1),('b7',1),('b8',0),('b9',0),('b10',0),
('c1',0),('c2',1),('c3',0),('c4',1),('c5',1),('c6',0),('c7',1),('c8',0),('c9',0),('c10',1);

SELECT * FROM movie;


-- Solution:





-- Not a generic solution
WITH t1 AS (
	SELECT seat, occupancy,
	ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
	, NTILE(3) OVER (ORDER BY (SELECT NULL)) AS partition_col
	FROM movie
), 
t2 AS (
	SELECT seat, occupancy, rn,
	rn - ROW_NUMBER() OVER (PARTITION BY partition_col ORDER BY (SELECT NULL)) AS diff
	FROM t1
	WHERE occupancy = 0
), 
t3 AS (
	SELECT seat,
	COUNT(seat) OVER (PARTITION BY diff) AS cnt
	FROM T2
)
SELECT seat FROM t3
WHERE cnt = 2