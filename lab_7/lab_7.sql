-- 1.
select city from hr.locations
intersect
select state_province from hr.locations;

--2 
select COUNT
from () 

select * from hr.employees;
select * from hr.departments;
select * from hr.locations;