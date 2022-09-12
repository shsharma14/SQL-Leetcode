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


SELECT * FROM lc_Department;
SELECT * FROM lc_Employee;

------ Solution 1
WITH src AS (
	SELECT dept.name, dept.id, MAX(emp.salary) AS salary
	FROM lc_Department dept
	LEFT JOIN lc_Employee emp ON dept.id = emp.departmentId
	GROUP BY dept.name, dept.id
)
SELECT src.name AS Department, emp.name AS Employee, src.salary
FROM src
JOIN lc_Employee emp ON src.salary = emp.salary AND src.id = emp.departmentId;


---- Solution 2
SELECT lc_Department.name AS 'Department', lc_Employee.name AS 'Employee', Salary
FROM lc_Employee
INNER JOIN lc_Department ON lc_Employee.DepartmentId = lc_Department.Id
WHERE lc_Employee.DepartmentId IN
    (   SELECT DepartmentId FROM lc_Employee
        GROUP BY DepartmentId
    ) AND 
	Salary IN (
	SELECT MAX(salary) FROM lc_Employee
        GROUP BY DepartmentId);


-- Solution 3
SET SHOWPLAN_XML OFF;
GO

WITH src AS (
    select dept.name AS Department, emp.name AS Employee, emp.salary,
    RANK() OVER (PARTITION BY dept.name ORDER BY emp.salary DESC) AS rnk
    from lc_employee emp 
    join lc_department dept on emp.departmentid = dept.id
)
SELECT Department, Employee, salary FROM src
WHERE rnk = 1;