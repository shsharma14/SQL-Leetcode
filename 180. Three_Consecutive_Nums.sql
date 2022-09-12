-- Ques: Write an SQL query to find all numbers that appear at least three times consecutively.

-- If you see consecutive in a question, think of self joins or lag/lead functions. 


use demo
go

DROP TABLE IF EXISTS Logs
GO

Create table Logs (id int, num int)
Truncate table Logs
insert into Logs (id, num) values ('1', '1')
insert into Logs (id, num) values ('2', '1')
insert into Logs (id, num) values ('3', '1')
insert into Logs (id, num) values ('4', '2')
insert into Logs (id, num) values ('5', '1')
insert into Logs (id, num) values ('6', '2')
insert into Logs (id, num) values ('7', '2')
insert into Logs (id, num) values ('8', '2')
insert into Logs (id, num) values ('9', '2')
insert into Logs (id, num) values ('10', '1')
insert into Logs (id, num) values ('11', '1')
insert into Logs (id, num) values ('12', '2')
insert into Logs (id, num) values ('13', '1')
insert into Logs (id, num) values ('14', '1')
insert into Logs (id, num) values ('15', '1')

select * from Logs
GO


--self join
select distinct l1.num as ConsecutiveNums
from Logs l1 
join Logs l2 on l1.id = l2.id + 1 and l1.num = l2.num -- increment id by 1 since we want number from next row.
join logs l3 on l2.id = l3.id + 1 and l2.num = l3.num



-- lead/lag


with cte as(
	select num,
	lag(num) over (order by id) as [lag],
	lead(num) over (order by id) as [lead]
	from logs
)
select distinct num from cte
	where num = [lag] and [lag] = [lead]
GO


-- Get the consecutive IDs instead of numbers: 

SELECT t1.id, t1.num, t2.id, t2.num, t3.id, t3.num
FROM Logs t1 
JOIN Logs t2 ON t1.id = t2.id+1
JOIN Logs t3 ON t1.id = t3.id-1




