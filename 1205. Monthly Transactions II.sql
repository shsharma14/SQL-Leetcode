USE demo
GO


Create table Transactionss (id int, country varchar(4), state varchar(20) CHECK (state IN ('approved', 'declined')), amount int, trans_date date)
Create table Chargebacks (trans_id int, trans_date date)
Truncate table Transactionss
insert into Transactionss (id, country, state, amount, trans_date) values ('101', 'US', 'approved', '1000', '2019-05-18')
insert into Transactionss (id, country, state, amount, trans_date) values ('102', 'US', 'declined', '2000', '2019-05-19')
insert into Transactionss (id, country, state, amount, trans_date) values ('103', 'US', 'approved', '3000', '2019-06-10')
insert into Transactionss (id, country, state, amount, trans_date) values ('104', 'US', 'declined', '4000', '2019-06-13')
insert into Transactionss (id, country, state, amount, trans_date) values ('105', 'US', 'approved', '5000', '2019-06-15')
Truncate table Chargebacks
insert into Chargebacks (trans_id, trans_date) values ('102', '2019-05-29')
insert into Chargebacks (trans_id, trans_date) values ('101', '2019-06-30')
insert into Chargebacks (trans_id, trans_date) values ('105', '2019-09-18')



Truncate table Transactionss
insert into Transactionss (id, country, state, amount, trans_date) values ('100', 'CB', 'declined', '4000', '2019-02-04')
insert into Transactionss (id, country, state, amount, trans_date) values ('101', 'BB', 'approved', '7000', '2019-02-17')
insert into Transactionss (id, country, state, amount, trans_date) values ('102', 'CA', 'declined', '6000', '2019-02-26')
insert into Transactionss (id, country, state, amount, trans_date) values ('103', 'AA', 'declined', '7000', '2019-04-01')

Truncate table Chargebacks
insert into Chargebacks (trans_id, trans_date) values ('100', '2019-03-29')
insert into Chargebacks (trans_id, trans_date) values ('102', '2019-02-28')
insert into Chargebacks (trans_id, trans_date) values ('103', '2019-05-09')


SELECT * FROM Chargebacks;
SELECT * FROM Transactionss;

-- Solution using UNPIVOT
WITH joined_data AS (    -- joining both tables
	SELECT t.id, t.country, t.state, t.amount
	, CONVERT(VARCHAR(7),t.trans_date,126) AS [transaction]
	, CONVERT(VARCHAR(7),c.trans_date,126) AS chargeback
	FROM Transactionss t
	LEFT JOIN Chargebacks c ON t.id = c.trans_id
)  
, unpivot_data AS (          -- UNPIVOT
	SELECT id,country, state, amount, [type], [date]
	FROM joined_data
	UNPIVOT (
		[date] FOR [type] IN ([transaction], chargeback)
	) AS tbl
)   
, final_data AS (          -- final data with counts and amounts sum
	SELECT [date] AS [month], country
	, ISNULL(SUM(CASE WHEN [state] = 'approved' AND [type] = 'transaction' THEN 1 ELSE 0 END),0) AS approved_count
	, ISNULL(SUM(CASE WHEN [state] = 'approved' AND [type] = 'transaction' THEN amount END),0) AS approved_amount
	, ISNULL(SUM(CASE WHEN [type] = 'chargeback' THEN 1 ELSE 0 END),0) AS chargeback_count
	, ISNULL(SUM(CASE WHEN [type] = 'chargeback' THEN amount ELSE 0 END),0) AS chargeback_amount
	FROM unpivot_data
	GROUP BY [date], country 
)
SELECT [month], country, approved_count, approved_amount, chargeback_count, chargeback_amount
FROM final_data
WHERE approved_count <> 0 OR approved_amount <> 0 OR chargeback_count <> 0 OR chargeback_amount <> 0; -- Filter where everything is 0


SELECT month, country,
SUM(CASE WHEN type='approved' THEN 1 ELSE 0 END) AS approved_count, 
SUM(CASE WHEN type='approved' THEN amount ELSE 0 END) AS approved_amount, 
SUM(CASE WHEN type='chargeback' THEN 1 ELSE 0 END) AS chargeback_count,
SUM(CASE WHEN type='chargeback' THEN amount ELSE 0 END) AS chargeback_amount
FROM (
(
SELECT left(t.trans_date, 7) AS month, t.country, amount, 'approved' AS type
FROM Transactionss AS t
WHERE state='approved'
)
UNION ALL (
SELECT left(c.trans_date, 7) AS month, t.country, amount, 'chargeback' AS type
FROM Transactionss AS t JOIN Chargebacks AS c
ON t.id = c.trans_id
)
) AS tt
GROUP BY tt.month, tt.country