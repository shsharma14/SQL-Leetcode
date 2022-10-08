USE demo
GO

DROP TABLE IF EXISTS Tasks;

Create table Tasks (task_id int, assignee_id int, submit_date date)
Truncate table Tasks
insert into Tasks (task_id, assignee_id, submit_date) values ('1', '1', '2022-06-13')
insert into Tasks (task_id, assignee_id, submit_date) values ('2', '6', '2022-06-14')
insert into Tasks (task_id, assignee_id, submit_date) values ('3', '6', '2022-06-15')
insert into Tasks (task_id, assignee_id, submit_date) values ('4', '3', '2022-06-18')
insert into Tasks (task_id, assignee_id, submit_date) values ('5', '5', '2022-06-19')
insert into Tasks (task_id, assignee_id, submit_date) values ('6', '7', '2022-06-19')

SELECT * FROM Tasks;

-- Date manipulation functions
SELECT submit_date
, DATENAME(WEEKDAY, submit_date) AS day_of_week
, DATENAME(MONTH, submit_date) AS month_of_task
, YEAR(submit_date) AS year_of_task
, MONTH(submit_date) AS numeric_month_of_task1
, DATEPART(MONTH, submit_date) AS numeric_month_of_task2
, DATEPART(DAY, submit_date) AS day_of_task
FROM Tasks;


-- Solution
SELECT 
SUM(CASE WHEN DATENAME(WEEKDAY, submit_date) IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END) AS weekend_cnt
, SUM(CASE WHEN DATENAME(WEEKDAY, submit_date) NOT IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END) AS weekday_cnt
FROM Tasks;