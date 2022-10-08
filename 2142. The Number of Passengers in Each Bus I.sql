USE demo
GO

DROP TABLE IF EXISTS Buses;
DROP TABLE IF EXISTS Passengers;

Create table Buses (bus_id int, arrival_time int)
Create table Passengers (passenger_id int, arrival_time int)
Truncate table Buses
insert into Buses (bus_id, arrival_time) values ('1', '2')
insert into Buses (bus_id, arrival_time) values ('2', '4')
insert into Buses (bus_id, arrival_time) values ('3', '7')
Truncate table Passengers
insert into Passengers (passenger_id, arrival_time) values ('11', '1')
insert into Passengers (passenger_id, arrival_time) values ('12', '5')
insert into Passengers (passenger_id, arrival_time) values ('13', '6')
insert into Passengers (passenger_id, arrival_time) values ('14', '7')


SELECT * FROM Buses;
SELECT * FROM Passengers;



SELECT * FROM Passengers p
INNER JOIN Buses b ON b.arrival_time >= p.arrival_time


SELECT p.passenger_id, MIN(b.arrival_time) FROM Passengers p
INNER JOIN Buses b ON b.arrival_time >= p.arrival_time
GROUP BY p.passenger_id