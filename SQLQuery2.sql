use demo
go

drop table if exists Trips
drop table if exists Users


Create table Trips (id int, client_id int, driver_id int, city_id int, status varchar(30), request_at varchar(50))
Create table Users (users_id int, banned varchar(50), role varchar(20))
Truncate table Trips
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('1', '1', '10', '1', 'completed', '2013-10-01')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('2', '2', '11', '1', 'cancelled_by_driver', '2013-10-01')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('3', '3', '12', '6', 'completed', '2013-10-01')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('4', '4', '13', '6', 'cancelled_by_client', '2013-10-01')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('5', '1', '10', '1', 'completed', '2013-10-02')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('6', '2', '11', '6', 'completed', '2013-10-02')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('7', '3', '12', '6', 'completed', '2013-10-02')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('8', '2', '12', '12', 'completed', '2013-10-03')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('9', '3', '10', '12', 'completed', '2013-10-03')
insert into Trips (id, client_id, driver_id, city_id, status, request_at) values ('10', '4', '13', '12', 'cancelled_by_driver', '2013-10-03')
Truncate table Users
insert into Users (users_id, banned, role) values ('1', 'No', 'client')
insert into Users (users_id, banned, role) values ('2', 'Yes', 'client')
insert into Users (users_id, banned, role) values ('3', 'No', 'client')
insert into Users (users_id, banned, role) values ('4', 'No', 'client')
insert into Users (users_id, banned, role) values ('10', 'No', 'driver')
insert into Users (users_id, banned, role) values ('11', 'No', 'driver')
insert into Users (users_id, banned, role) values ('12', 'No', 'driver')
insert into Users (users_id, banned, role) values ('13', 'No', 'driver')

select * from trips
select * from users
GO

-- The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests 
-- with unbanned users on that day.

-- Write a SQL query to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and
-- "2013-10-03". Round Cancellation Rate to two decimal points.

with subtable as(
select t.id, t.client_id, t.driver_id, t.city_id, t.status, t.request_at, c.banned as client_banned, d.banned as driver_banned,
	count(t.id) OVER(partition by t.request_at) AS total_valid_requests
	from trips t
	join users c on c.users_id = t.client_id
	join users d on d.users_id = t.driver_id
	where (c.banned = 'No' and d.banned = 'No')
)
select * from subtable
	count(id) as cnt_cancelled_rides, request_at
	from subtable
	where status like 'canc%' and (client_banned = 'No' and driver_banned = 'No')
	group by request_at




	select * from 
(select t.id, t.client_id, t.driver_id, t.city_id, t.status, t.request_at, c.banned as client_banned, d.banned as driver_banned
	from trips t
	join users c on c.users_id = t.client_id
	join users d on d.users_id = t.driver_id) as  x
	cross join 
	(select t.id, t.client_id, t.driver_id, t.city_id, t.status, t.request_at, c.banned as client_banned, d.banned as driver_banned
	from trips t
	join users c on c.users_id = t.client_id
	join users d on d.users_id = t.driver_id) as x1



	where (c.banned = 'No' and d.banned = 'No') and status like 'canc%'


