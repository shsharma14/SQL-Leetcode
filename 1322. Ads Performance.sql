USE demo
GO

DROP TABLE IF EXISTS Ads
GO

Create table Ads (ad_id int, 
					user_id int, 
					[action] VARCHAR(20) CHECK ([action] IN ('Clicked', 'Viewed', 'Ignored'))
)
Truncate table Ads
insert into Ads (ad_id, user_id, action) values ('1', '1', 'Clicked')
insert into Ads (ad_id, user_id, action) values ('2', '2', 'Clicked')
insert into Ads (ad_id, user_id, action) values ('3', '3', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('5', '5', 'Ignored')
insert into Ads (ad_id, user_id, action) values ('1', '7', 'Ignored')
insert into Ads (ad_id, user_id, action) values ('2', '7', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('3', '5', 'Clicked')
insert into Ads (ad_id, user_id, action) values ('1', '4', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('2', '11', 'Viewed')
insert into Ads (ad_id, user_id, action) values ('1', '2', 'Clicked')

SELECT * FROM Ads;



-- Solution
WITH ads_data AS (
	SELECT ad_id,
	CASE WHEN action = 'clicked' THEN 1 ELSE 0 END AS clicked_binary,
	CASE WHEN action = 'viewed' THEN 1 ELSE 0 END AS viewed_binary
	FROM Ads
)
SELECT ad_id,
CAST(ISNULL(100.0 * SUM(clicked_binary) / NULLIF((SUM(clicked_binary) + SUM(viewed_binary)),0),0) AS DECIMAL(5,2)) AS ctr
FROM ads_data
GROUP BY ad_id
ORDER BY ctr DESC, ad_id;



-- Without cte
SELECT ad_id,
CAST(
	ISNULL(
		100.0 * SUM(CASE WHEN action = 'clicked' THEN 1 ELSE 0 END) / 
		NULLIF(SUM(CASE WHEN action = 'clicked' OR action = 'viewed' THEN 1 ELSE 0 END),0)
	,0) 
AS DECIMAL(5,2)) AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id





SELECT NULLIF(2,0)
SELECT ISNULL(NULL,(SELECT 1))
SELECT COALESCE(NULL,(SELECT 1))




















