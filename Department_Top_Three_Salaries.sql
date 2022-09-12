-- A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee 
-- who has a salary in the top three unique salaries for that department.

-- Write an SQL query to find the employees who are high earners in each of the departments.


use tinyu
go

drop table if exists Employee
drop table if exists Department
GO

Create table Employee (id int, name varchar(255), salary int, departmentId int)
Create table Department (id int, name varchar(255))
Truncate table Employee
insert into Employee (id, name, salary, departmentId) values ('1', 'Joe', '85000', '1')
insert into Employee (id, name, salary, departmentId) values ('2', 'Henry', '80000', '2')
insert into Employee (id, name, salary, departmentId) values ('3', 'Sam', '60000', '2')
insert into Employee (id, name, salary, departmentId) values ('4', 'Max', '90000', '1')
insert into Employee (id, name, salary, departmentId) values ('5', 'Janet', '69000', '1')
insert into Employee (id, name, salary, departmentId) values ('6', 'Randy', '85000', '1')
insert into Employee (id, name, salary, departmentId) values ('7', 'Will', '70000', '1')
insert into Employee (id, name, salary, departmentId) values ('8', 'Aaron', '55000', '2')
insert into Employee (id, name, salary, departmentId) values ('9', 'Shubh', '40000', '2')

Truncate table Department
insert into Department (id, name) values ('1', 'IT')
insert into Department (id, name) values ('2', 'Sales')

/* Write your T-SQL query statement below */

with subtable as(
select 
    dense_rank() OVER(partition by d.name ORDER BY e.salary desc) as rnk, 
    d.name as Department , e.name as Employee, salary
    from employee e
    join department d
    on e.departmentId = d.id
)
select Department, Employee, Salary, rnk from subtable
where rnk <=3


-- get top n rows from each group?


-- get the top two students in each year? If same gpa, return students with same gpa.

with subtable as(
select student_firstname, student_lastname, student_year_name, student_gpa,
	ROW_NUMBER() over (PARTITION BY student_year_name ORDER BY student_gpa DESC) as row_num 
	from students
)
select * from subtable 
where row_num < 3


-- get the top two students in each year? If same gpa, return 1 students with gpa less than max gpa.

with subtable as(
select student_firstname, student_lastname, student_year_name, student_gpa,
	DENSE_RANK() over (PARTITION BY student_year_name ORDER BY student_gpa DESC) as rnk 
	from students
)
select * from subtable 
where rnk < 3