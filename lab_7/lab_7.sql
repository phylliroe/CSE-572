-- 1.
select city from hr.locations
intersect
select state_province from hr.locations;

-- 2.
select count(city) as DISTINCT_COUNT
from (
    select city from hr.locations union select state_province from hr.locations
    minus
    select city from hr.locations intersect select state_province from hr.locations 
);

-- 3. 
select count(city) as TOTAL_ENTRIES
from(
    select city from hr.locations
    union
    select state_province from hr.locations
);

-- 4. 


-- 5. 
create table empl_dup as select * from hr.employees;

-- 7
-- /*LAB07_6
-- Loop-Perez, Andrew 
-- */
create view EMPLOYEES_VU as 
select 
    first_name || ' ' || last_name as EMPLOYEE,
    department_id
from hr.employees;

-- 7a
desc employees_vu;
-- 7b
-- 7c
select employee, department_id from employees_vu;


select * from hr.employees;
select * from hr.departments;
select * from hr.locations;


select * from empl_dup;
select * from employees_vu;

