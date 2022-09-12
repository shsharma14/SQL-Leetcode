use tinyu
go

select * from students 
go

with src as (
select student_gpa,
ROW_NUMBER() OVER (ORDER BY student_gpa DESC) as rownum_desc,
ROW_NUMBER() OVER (ORDER BY student_gpa) as rownum
from students
)
select avg(student_gpa) as Median
from src
where rownum in (rownum_desc - 1, rownum_desc, rownum_desc + 1)

