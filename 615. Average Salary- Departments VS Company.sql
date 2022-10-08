USE demo
GO

Create table  Salary (id int, Employe_id int, amount int, pay_date date)
Create table Employe (Employe_id int, department_id int)
Truncate table Salary
insert into Salary (id, Employe_id, amount, pay_date) values ('1', '1', '9000', '2017/03/31')
insert into Salary (id, Employe_id, amount, pay_date) values ('2', '2', '6000', '2017/03/31')
insert into Salary (id, Employe_id, amount, pay_date) values ('3', '3', '10000', '2017/03/31')
insert into Salary (id, Employe_id, amount, pay_date) values ('4', '1', '7000', '2017/02/28')
insert into Salary (id, Employe_id, amount, pay_date) values ('5', '2', '6000', '2017/02/28')
insert into Salary (id, Employe_id, amount, pay_date) values ('6', '3', '8000', '2017/02/28')
Truncate table Employe
insert into Employe (Employe_id, department_id) values ('1', '1')
insert into Employe (Employe_id, department_id) values ('2', '2')
insert into Employe (Employe_id, department_id) values ('3', '2')


SELECT * FROM Salary;
SELECT * FROM Employe;



WITH src AS (
	SELECT s.id, s.Employe_id, s.amount,
	CONVERT(VARCHAR(7), s.pay_date, 126) AS pay_date,
	e.department_id,
	AVG(s.amount) OVER (PARTITION BY e.department_id, CONVERT(VARCHAR(7), s.pay_date, 126)) AS avg_amount,
	AVG(s.amount) OVER (PARTITION BY CONVERT(VARCHAR(7), s.pay_date, 126)) AS companys_average
	FROM Salary s
	INNER JOIN Employe e ON s.Employe_id = e.Employe_id
)
SELECT pay_date AS pay_month, department_id,
MAX(CASE WHEN avg_amount > companys_average THEN 'Higher' 
	 WHEN avg_amount < companys_average THEN 'Lower'
	 ELSE 'Same'
END) AS comparison
FROM src
GROUP BY pay_date, department_id

