
use demo
go

drop table if exists employees

Create table Employees (id int, name varchar(255), salary int, managerId int)
Truncate table Employees
insert into Employees (id, name, salary, managerId) values ('1', 'Joe', '70000', '3')
insert into Employees (id, name, salary, managerId) values ('2', 'Henry', '80000', '4')
insert into Employees (id, name, salary, managerId) values ('3', 'Sam', '60000', NULL)
insert into Employees (id, name, salary, managerId) values ('4', 'Max', '90000', NULL)


select * from Employees


-- employees who are also managers?

select *
	from Employees e1
	join Employees e2 on e1.id = e2.managerId



-- employees who earn more than their managers?
select m.name
from employees m
join employees e on e.id = m.managerid
where m.salary > e.salary


select *
from employees emp
join employees man on emp.id = man.managerId

select *
from employees m
join employees e on e.id = m.managerid


