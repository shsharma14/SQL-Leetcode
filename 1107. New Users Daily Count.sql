-- Write an SQL query to reports for every date within at most 90 days from today, the number of users that logged in for the first time on that date. 
--Assume today is 2019-06-30.
--Return the result table in any order.


DROP TABLE IF EXISTS Traffic
GO

Create table Traffic (user_id int, activity VARCHAR(20) CHECK (activity IN ('login', 'logout', 'jobs', 'groups', 'homepage')), activity_date date)
Truncate table Traffic
insert into Traffic (user_id, activity, activity_date) values ('1', 'login', '2019-05-01')
insert into Traffic (user_id, activity, activity_date) values ('1', 'homepage', '2019-05-01')
insert into Traffic (user_id, activity, activity_date) values ('1', 'logout', '2019-05-01')
insert into Traffic (user_id, activity, activity_date) values ('2', 'login', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('2', 'logout', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('3', 'login', '2019-01-01')
insert into Traffic (user_id, activity, activity_date) values ('3', 'jobs', '2019-01-01')
insert into Traffic (user_id, activity, activity_date) values ('3', 'logout', '2019-01-01')
insert into Traffic (user_id, activity, activity_date) values ('4', 'login', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('4', 'groups', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('4', 'logout', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('5', 'login', '2019-03-01')
insert into Traffic (user_id, activity, activity_date) values ('5', 'logout', '2019-03-01')
insert into Traffic (user_id, activity, activity_date) values ('5', 'login', '2019-06-21')
insert into Traffic (user_id, activity, activity_date) values ('5', 'logout', '2019-06-21')

SELECT * FROM Traffic;


SELECT * FROM Traffic
ORDER BY activity_date;



WITH src AS (
	SELECT *,
	ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY activity_date) AS rn
	FROM Traffic
	WHERE activity = 'login'
)
, final_data AS (
	SELECT activity_date, COUNT(DISTINCT user_id) AS cnt
	FROM src
	WHERE rn = 1
	GROUP BY activity_date
)
SELECT activity_date AS login_date
, cnt AS user_count
FROM final_data
WHERE DATEDIFF(DAY,activity_date, '2019-06-30') < 91







