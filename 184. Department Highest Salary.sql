USE demo
GO

DROP TABLE IF EXISTS lc_Employee;
DROP TABLE IF EXISTS lc_Department;

Create table lc_Employee (id int, name varchar(255), salary int, departmentId int)
Create table lc_Department (id int, name varchar(255))
Truncate table lc_Employee
insert into lc_Employee (id, name, salary, departmentId) values ('1', 'Joe', '70000', '1')
insert into lc_Employee (id, name, salary, departmentId) values ('2', 'Jim', '90000', '1')
insert into lc_Employee (id, name, salary, departmentId) values ('3', 'Henry', '80000', '2')
insert into lc_Employee (id, name, salary, departmentId) values ('4', 'Sam', '60000', '2')
insert into lc_Employee (id, name, salary, departmentId) values ('5', 'Max', '90000', '1')
Truncate table lc_Department
insert into lc_Department (id, name) values ('1', 'IT')
insert into lc_Department (id, name) values ('2', 'Sales')
insert into lc_Department (id, name) values ('3', 'Ssssales')


SELECT * FROM lc_Department;
SELECT * FROM lc_Employee;

------ Solution 1

WITH src AS (
	SELECT dept.name, dept.id, MAX(emp.salary) AS salary
	FROM lc_Department dept
	JOIN lc_Employee emp ON dept.id = emp.departmentId
	GROUP BY dept.name, dept.id
)
SELECT src.name AS Department, emp.name AS Employee, src.salary
FROM src
JOIN lc_Employee emp ON src.salary = emp.salary AND src.id = emp.departmentId;




-- Solution 2

WITH ranked_salary_data AS (
    select dept.name AS Department, emp.name AS Employee, emp.salary
	, RANK() OVER (PARTITION BY dept.name ORDER BY emp.salary DESC) AS rnk
	FROM lc_employee emp 
	INNER JOIN lc_department dept ON emp.departmentid = dept.id
)
SELECT Department, Employee, salary FROM ranked_salary_data
WHERE rnk = 1;



