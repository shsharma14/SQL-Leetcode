USE demo
GO

DROP TABLE IF EXISTS Playback;
DROP TABLE IF EXISTS Ad;

Create table Playback(session_id int,customer_id int,start_time int,end_time int)
Create table Ad (ad_id int, customer_id int, timestamp int)
Truncate table Playback
insert into Playback (session_id, customer_id, start_time, end_time) values ('1', '1', '1', '5')
insert into Playback (session_id, customer_id, start_time, end_time) values ('2', '1', '15', '23')
insert into Playback (session_id, customer_id, start_time, end_time) values ('3', '2', '10', '12')
insert into Playback (session_id, customer_id, start_time, end_time) values ('4', '2', '17', '28')
insert into Playback (session_id, customer_id, start_time, end_time) values ('5', '2', '2', '8')
Truncate table Ad
insert into Ad (ad_id, customer_id, timestamp) values ('1', '1', '5')
insert into Ad (ad_id, customer_id, timestamp) values ('2', '2', '17')
insert into Ad (ad_id, customer_id, timestamp) values ('3', '2', '20')


SELECT * FROM Ad;
SELECT * FROM Playback;


SELECT *
FROM Ad 
LEFT JOIN Playback ON Ad.customer_id = Playback.customer_id
WHERE Ad.timestamp NOT BETWEEN Playback.start_time AND Playback.end_time



SELECT      * 
FROM        Playback P
LEFT JOIN   Ad A ON P.customer_id = A.customer_id AND  A.timestamp BETWEEN P.start_time AND P.end_time 
WHERE       A.timestamp IS NULL

