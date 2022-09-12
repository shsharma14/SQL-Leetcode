USE demo
GO


DROP TABLE IF EXISTS company_company_employees;

Create table company_employees (employee_id int, employee_name varchar(30), manager_id int)
Truncate table company_employees
insert into company_employees (employee_id, employee_name, manager_id) values ('1', 'Boss', '1')
insert into company_employees (employee_id, employee_name, manager_id) values ('3', 'Alice', '3')
insert into company_employees (employee_id, employee_name, manager_id) values ('2', 'Bob', '1')
insert into company_employees (employee_id, employee_name, manager_id) values ('4', 'Daniel', '2')
insert into company_employees (employee_id, employee_name, manager_id) values ('7', 'Luis', '4')
insert into company_employees (employee_id, employee_name, manager_id) values ('8', 'John', '3')
insert into company_employees (employee_id, employee_name, manager_id) values ('9', 'Angela', '8')
insert into company_employees (employee_id, employee_name, manager_id) values ('77', 'Robert', '1')


SELECT * FROM company_employees;