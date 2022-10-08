USE demo
GO

DROP TABLE IF EXISTS Submissions;


Create table Submissions (sub_id int, parent_id int)
Truncate table Submissions
insert into Submissions (sub_id, parent_id) values (1, NULL)
insert into Submissions (sub_id, parent_id) values (2, NULL)
insert into Submissions (sub_id, parent_id) values (1, NULL)
insert into Submissions (sub_id, parent_id) values (12, NULL)
insert into Submissions (sub_id, parent_id) values (3, 1)
insert into Submissions (sub_id, parent_id) values (5, 2)
insert into Submissions (sub_id, parent_id) values (3, 1)
insert into Submissions (sub_id, parent_id) values (4, 1)
insert into Submissions (sub_id, parent_id) values (9, 1)
insert into Submissions (sub_id, parent_id) values (10, 2)
insert into Submissions (sub_id, parent_id) values (6, 7)


SELECT * FROM Submissions;

-- Solution
WITH posts AS ( -- These are all the posts
	SELECT DISTINCT sub_id AS post_id 
	FROM Submissions
	WHERE parent_id IS NULL
)
SELECT p.post_id, COUNT(DISTINCT s.sub_id) AS number_of_comments
FROM posts p
LEFT JOIN Submissions s ON p.post_id = s.parent_id
GROUP BY p.post_id