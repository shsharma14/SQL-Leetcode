USE demo
GO

DROP TABLE IF EXISTS Relations
GO

Create table Relations (user_id int, follower_id int)
Truncate table Relations
insert into Relations (user_id, follower_id) values ('1', '3')
insert into Relations (user_id, follower_id) values ('2', '3')
insert into Relations (user_id, follower_id) values ('7', '3')
insert into Relations (user_id, follower_id) values ('1', '4')
insert into Relations (user_id, follower_id) values ('2', '4')
insert into Relations (user_id, follower_id) values ('7', '4')
insert into Relations (user_id, follower_id) values ('1', '5')
insert into Relations (user_id, follower_id) values ('2', '6')
insert into Relations (user_id, follower_id) values ('7', '5')

SELECT * FROM Relations;


 -- COUNTING COMMON DISTINCT FOLLOWERS FOR GIVEN CONDITIONS
WITH CTE_COUNT_FOLLOWERS AS 
(SELECT R1.USER_ID, R2.USER_ID AS USER_ID2, COUNT(DISTINCT R1.FOLLOWER_ID) AS COUNT
 FROM RELATIONS R1
 JOIN RELATIONS R2
 -- The result table should contain the pairs user1_id and user2_id where user1_id < user2_id
 ON R1.FOLLOWER_ID = R2.FOLLOWER_ID AND R1.USER_ID <> R2.USER_ID AND R1.USER_ID < R2.USER_ID
 GROUP BY R1.USER_ID, R2.USER_ID)
 SELECT USER_ID AS USER1_ID, USER_ID2 AS USER2_ID 
 FROM CTE_COUNT_FOLLOWERS
 WHERE COUNT = (SELECT MAX(COUNT) FROM CTE_COUNT_FOLLOWERS)