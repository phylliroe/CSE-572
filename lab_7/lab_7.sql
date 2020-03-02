-- Name: Andrew Loop-Perez
-- ID: 006198799
-- Course: CSE 572 Winter 2020
-- Assignment: Lab #7


-- 1. Using a set operator write a query to determine the names that
--    appear in both the city and state_province fields of the locations table
select city from hr.locations
intersect
select state_province from hr.locations;

-- 2. Write a query (using an inline view) that returns the count of distinct entires
--    that appear in either the city or the state_province fields
select count(city) as DISTINCT_COUNT
from (
    select city from hr.locations union select state_province from hr.locations
    minus
    select city from hr.locations intersect select state_province from hr.locations 
);

-- 3. Return a count of how many total entires are in the city and state_province fields 
select count(city) as TOTAL_ENTRIES
from(
    select city from hr.locations
    union
    select state_province from hr.locations
);

-- 4. Find all employees who work in department 10 using the minus operator
select * from hr.employees
minus
select * from hr.employees where department_id is null or department_id not like '10';

-- 5. Duplicate hr.employees as a new table named empl_dup
create table empl_dup as (select * from hr.employees);

/*LAB07_6
Loop-Perez, Andrew 
*/
-- 6. Create a view called EMPLOYEES_VU
create or replace view EMPLOYEES_VU as 
select 
    first_name || ' ' || last_name as EMPLOYEE,
    department_id
from hr.employees;

-- 6a. Display the contents of EMPLOYEES_VU
desc employees_vu;
-- 6b. Select view_name and text from USER_VIEWS   
select view_name, text from user_views where view_name = 'EMPLOYEES_VU';
-- 6c. Display employee names and department numbers 
select * from employees_vu;

/* LAB07_7
Loop-Perez, Andrew
*/ 
-- 7. Recreate view name DEPT50
create or replace view DEPT50 as
select 
    employee_id as EMPNO,
    last_name as EMPLOYEE,
    department_id as DEPTNO
from hr.employees
where department_id = '50'; 

-- 7a. Display the structure and contents
desc dept50;
-- 7b. Select view_name and text from USER_VIEWS   
select view_name, text from user_views where view_name = 'DEPT50';
-- 7c. Attept to re-assign Matos to department 80
update view DEPT50
set DEPTNO = '80'
where EMPLOYEE = 'Matos';



