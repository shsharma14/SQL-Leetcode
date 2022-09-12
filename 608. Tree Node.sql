USE demo
GO

DROP TABLE IF EXISTS Tree
GO

Create table Tree (id int, p_id int)
Truncate table Tree
insert into Tree (id, p_id) values ('1', NULL)
insert into Tree (id, p_id) values ('2', '1')
insert into Tree (id, p_id) values ('3', '1')
insert into Tree (id, p_id) values ('4', '2')
insert into Tree (id, p_id) values ('5', '2')

SELECT * FROM Tree

-- We can do this using CASE statement. There is an edge case when there is only 1 node in the tree. That node will be called as the root node.
-- If the first WHEN statement is TRUE, other conditional statements won't be checked. So, we need to put the Root condition first.
SELECT id,
	CASE WHEN p_id IS NULL THEN 'Root'
		 WHEN id NOT IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
		 ELSE 'Inner'
	END AS [Type]
FROM Tree


-- Below statements will give different rows

SELECT id FROM 
Tree WHERE id NOT IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL)

SELECT id FROM 
Tree WHERE id NOT IN (SELECT p_id FROM Tree)

-- Below queries return different results. Both should return True but second query doesn't return true
-- NOT IN returns 0 records when compared against an unknown value
-- https://stackoverflow.com/questions/129077/null-values-inside-not-in-clause

select 'true' where 3 in (1, 2, 3, null)
select 'true' where 3 not in (1, 2, null)