USE demo
GO

DROP TABLE IF EXISTS Failed
DROP TABLE IF EXISTS Succeeded

Create table Failed (fail_date date)
Create table Succeeded (success_date date)
Truncate table Failed
insert into Failed (fail_date) values ('2018-12-28')
insert into Failed (fail_date) values ('2018-12-29')
insert into Failed (fail_date) values ('2019-01-04')
insert into Failed (fail_date) values ('2019-01-05')
Truncate table Succeeded
insert into Succeeded (success_date) values ('2018-12-30')
insert into Succeeded (success_date) values ('2018-12-31')
insert into Succeeded (success_date) values ('2019-01-01')
insert into Succeeded (success_date) values ('2019-01-02')
insert into Succeeded (success_date) values ('2019-01-03')
insert into Succeeded (success_date) values ('2019-01-06')



SELECT * FROM Failed;
SELECT * FROM Succeeded;


WITH final_data AS (
	SELECT fail_date, period_state 
	FROM 
	(SELECT fail_date, 'failed' AS period_state FROM Failed
	UNION ALL
	SELECT success_date, 'succeeded' FROM Succeeded) AS tbl
	WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
)
, groups as (
SELECT fail_date, period_state
,ROW_NUMBER() OVER(ORDER BY fail_date ASC) -  ROW_NUMBER() OVER(PARTITION BY period_state ORDER BY fail_date ASC) AS diff
FROM final_data
) 
SELECT period_state, MIN(fail_date) AS start_date, MAX(fail_date) AS end_date
FROM groups
GROUP BY diff, period_state
ORDER BY start_date