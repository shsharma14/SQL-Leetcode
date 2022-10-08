USE demo;

DROP TABLE IF EXISTS Genders;

Create table Genders (user_id int, gender VARCHAR(20) CHECK (gender IN ('female', 'other', 'male')))
Truncate table Genders
insert into Genders (user_id, gender) values ('4', 'male')
insert into Genders (user_id, gender) values ('7', 'female')
insert into Genders (user_id, gender) values ('2', 'other')
insert into Genders (user_id, gender) values ('5', 'male')
insert into Genders (user_id, gender) values ('3', 'female')
insert into Genders (user_id, gender) values ('8', 'male')
insert into Genders (user_id, gender) values ('6', 'other')
insert into Genders (user_id, gender) values ('1', 'other')
insert into Genders (user_id, gender) values ('9', 'female')


SELECT * FROM Genders;


SELECT user_id, gender
FROM Genders
GROUP BY user_id, gender

select user_id, gender
from genders
order by dense_rank() over (partition by gender order by user_id asc), len(gender) desc;


WITH CTE AS
(
SELECT 
    user_id,
    gender,
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY user_id ASC) AS rnk,
    CASE WHEN gender = 'female' THEN 1
         WHEN gender = 'other' THEN 2
         WHEN gender = 'male' THEN 3 END AS GenderOrder
FROM Genders
)
SELECT
    user_id,
    gender
FROM CTE
ORDER BY rnk,GenderOrder