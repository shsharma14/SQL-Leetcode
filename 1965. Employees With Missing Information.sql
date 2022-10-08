USE demo
GO

DROP TABLE IF EXISTS Company_Employees
DROP TABLE IF EXISTS Salaries


Create table Company_Employees (employee_id int, name varchar(30))
Create table Salaries (employee_id int, salary int)
Truncate table Company_Employees
insert into Company_Employees (employee_id, name) values ('2', 'Crew')
insert into Company_Employees (employee_id, name) values ('4', 'Haven')
insert into Company_Employees (employee_id, name) values ('5', 'Kristian')
Truncate table Salaries
insert into Salaries (employee_id, salary) values ('5', '76071')
insert into Salaries (employee_id, salary) values ('1', '22517')
insert into Salaries (employee_id, salary) values ('4', '63539')


SELECT * FROM Company_Employees;
SELECT * FROM Salaries;


-- Solution 1: Using UNION

SELECT employee_id 
FROM Company_Employees
WHERE employee_id NOT IN (SELECT employee_id FROM Salaries)
UNION 
SELECT employee_id 
FROM Salaries
WHERE employee_id NOT IN (SELECT employee_id FROM Company_Employees)
ORDER BY employee_id



-- Solution 2: Using FULL OUTER JOIN

SELECT *
FROM Company_Employees e 
FULL OUTER JOIN Salaries s ON e.employee_id = s.employee_id
WHERE e.name IS NULL OR s.salary IS NULL


SELECT 
CASE WHEN s.salary IS NULL THEN e.employee_id
	 WHEN e.name IS NULL THEN s.employee_id
END AS employee_id
FROM Company_Employees e 
FULL OUTER JOIN Salaries s ON e.employee_id = s.employee_id
WHERE e.name IS NULL OR s.salary IS NULL
ORDER BY employee_id




