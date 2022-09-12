-- Write an SQL query to report the ID of each driver and the number of times they were a passenger.

USE demo
GO

DROP TABLE IF EXISTS Rides
GO

Create table Rides (ride_id int, driver_id int, passenger_id int)
Truncate table Rides
insert into Rides (ride_id, driver_id, passenger_id) values ('1', '7', '1')
insert into Rides (ride_id, driver_id, passenger_id) values ('2', '7', '2')
insert into Rides (ride_id, driver_id, passenger_id) values ('3', '11', '1')
insert into Rides (ride_id, driver_id, passenger_id) values ('4', '11', '7')
insert into Rides (ride_id, driver_id, passenger_id) values ('5', '11', '7')
insert into Rides (ride_id, driver_id, passenger_id) values ('6', '11', '3')

-- testcase 2
insert into Rides (ride_id, driver_id, passenger_id) values (8,41,22)
insert into Rides (ride_id, driver_id, passenger_id) values (3,41,22)
insert into Rides (ride_id, driver_id, passenger_id) values (9,20,41)
insert into Rides (ride_id, driver_id, passenger_id) values (6,41,8)
insert into Rides (ride_id, driver_id, passenger_id) values (2,41,22)
insert into Rides (ride_id, driver_id, passenger_id) values (1,41,22)
insert into Rides (ride_id, driver_id, passenger_id) values (4,20,57)
insert into Rides (ride_id, driver_id, passenger_id) values (5,20,41)
insert into Rides (ride_id, driver_id, passenger_id) values (7,41,5)


SELECT * FROM Rides;


WITH src AS (
	SELECT passenger_id, COUNT(1) AS cnt
	FROM Rides
	GROUP BY passenger_id
)
SELECT DISTINCT t1.driver_id, ISNULL(src.cnt,0) AS cnt FROM src
RIGHT JOIN Rides t1 ON src.passenger_id = t1.driver_id