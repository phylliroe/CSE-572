-- Name: Andrew Loop-Perez
-- ID: 006198799
-- Course: CSE 572
-- Assignment: Lab #3

-- Question 1
select 
    e.last_name,
    d.department_id,
    d.department_name
from
    hr.employees e 
    left join hr.departments d on e.department_id = d.department_id
order by e.department_id desc;

-- Question 2
select distinct 
    j.job_title,
    l.city || ' ' || l.state_province || ' ' || l.country_id as LOCATION
    from hr.jobs j
    join hr.employees e on j.job_id = e.job_id
    join hr.departments d on e.department_id = d.department_id
    join hr.locations l on d.location_id = l.location_id
where e.department_id ='80';

-- Question 3 
select 
    e.last_name,
    d.department_name,
    l.location_id,
    l.city
from hr.employees e
join hr.departments d on e.department_id = d.department_id
join hr.locations l on d.location_id = l.location_id
where e.commission_pct is not null;


-- Question 4
select 
    e.last_name,
    d.department_name
from hr.employees e
join hr.departments d on e.department_id = d.department_id
where e.last_name like '%a%';

-- Question 5
-- SPECIFY EMPLOYEES IN TORONTO
select 
    e.last_name,
    j.job_title,
    d.department_id,
    d.department_name
from hr.employees e
join hr.jobs j on e.job_id = j.job_id
join hr.departments d on e.department_id = d.department_id;

-- Question 6
select 
    e.employee_id,
    e.last_name
from hr.employees e;







