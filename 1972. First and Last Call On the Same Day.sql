--Write an SQL query to report the IDs of the users whose first and 
--last calls on any day were with the same person. Calls are counted regardless of being the caller or the recipient.

USE demo
GO

DROP TABLE IF EXISTS Calls
GO


Create table Calls (caller_id int, recipient_id int, call_time datetime)
Truncate table Calls
insert into Calls (caller_id, recipient_id, call_time) values ('8', '4', '2021-08-24 17:46:07')
insert into Calls (caller_id, recipient_id, call_time) values ('4', '8', '2021-08-24 19:57:13')
insert into Calls (caller_id, recipient_id, call_time) values ('5', '1', '2021-08-11 05:28:44')
insert into Calls (caller_id, recipient_id, call_time) values ('8', '3', '2021-08-17 04:04:15')
insert into Calls (caller_id, recipient_id, call_time) values ('11', '3', '2021-08-17 13:07:00')
insert into Calls (caller_id, recipient_id, call_time) values ('8', '11', '2021-08-17 22:22:22')


SELECT * FROM Calls
GO

WITH cte AS(
    SELECT *, 
        RANK() OVER(PARTITION BY user1, CAST(call_time AS DATE) ORDER BY call_time) AS rk1,
        RANK() OVER(PARTITION BY user1, CAST(call_time AS DATE) ORDER BY call_time DESC) AS rk2
    FROM
        (SELECT
            caller_id AS user1, recipient_id AS user2, call_time
        FROM calls
        UNION
        SELECT
            recipient_id AS user1, caller_id AS user2, call_time
        FROM calls) t
)


SELECT
    DISTINCT c1.user1 AS user_id
FROM
    cte c1, cte c2
WHERE
    c1.rk1 = 1 AND c2.rk2 = 1 AND CONCAT(c1.user1, c1.user2) = CONCAT(c2.user1, c2.user2)
;