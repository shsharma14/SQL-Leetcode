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


select user_id,min(activity_date) as login_date
from traffic
where activity='login'
group by user_id