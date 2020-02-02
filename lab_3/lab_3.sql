-- Name: Andrew Loop-Perez
-- ID: 006198799
-- Course: CSE 572
-- Assignment: Lab #3

-- Question 1. Create a query to display the last name, department number and department name for all employees.
select 
    e.last_name,
    d.department_id,
    d.department_name
from
    hr.employees e 
    left join hr.departments d on e.department_id = d.department_id
order by e.department_id desc;

-- Question 2. Create a unique listing of all jobs that in department 80. 
-- Include the location of the department in the output.
select distinct 
    j.job_title,
    l.city || ' ' || l.state_province || ' ' || l.country_id as LOCATION
    from hr.jobs j
    join hr.employees e on j.job_id = e.job_id
    join hr.departments d on e.department_id = d.department_id
    join hr.locations l on d.location_id = l.location_id
where e.department_id ='80';

-- Question 3. Create a query to display the employee’s last name, department name, location ID and city 
-- of all employees who earn a commission.
select 
    e.last_name,
    d.department_name,
    l.location_id,
    l.city
from hr.employees e
join hr.departments d on e.department_id = d.department_id
join hr.locations l on d.location_id = l.location_id
where e.commission_pct is not null;


-- Question 4. For each employee who has an ‘a’ (lowercase) in his/her last name, 
-- display the employee’s last name and department name.
select 
    e.last_name,
    d.department_name
from hr.employees e
join hr.departments d on e.department_id = d.department_id
where e.last_name like '%a%';

-- Question 5 Write a query that displays the last name, job, department number and department name 
-- for all employees who work in Toronto.
select 
    e.last_name,
    j.job_title,
    d.department_id,
    d.department_name
from hr.employees e
join hr.jobs j on e.job_id = j.job_id
join hr.departments d on e.department_id = d.department_id
where d.location_id = '1800';

-- Question 6. Create a query to display the employee’s last name and employee number 
-- along with his/her manager’s last name and manager number. Label the columns Employee, Emp#, Manager and Mgr#, respectively. 
select 
    e.last_name as Employee,
    e.employee_id as Emp#,
    m.last_name as Manager,
    m.employee_id as Mgr#
from hr.employees e
join hr.employees m on e.manager_id = m.employee_id;

-- Question 7. Modify Question 6 to display all employees including King, who has no manager. 
-- Order the results by the employee number.  
select 
    e.last_name as Employee,
    e.employee_id as Emp#,
    m.last_name as Manager,
    m.employee_id as Mgr#
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id
order by Emp#;

-- Question 8. Create a query to display the name and hire date of any employee hired after Davies. 
select 
    first_name || ' ' || last_name as NAME,
    hire_date
from hr.employees
where hire_date > ( select hire_date from hr.employees where last_name = 'Davies');

-- Question 9. Display the names and hire dates for all employees who were hired before their managers, 
-- along with their manager’s names and hire dates. Label the columns Employee, Emp Hired, Manager, and Mgr Hired.  
select 
    e.first_name || ' '|| e.last_name as Employee,
    e.hire_date as "Emp Hired",
    m.first_name || ' ' || m.last_name as Manager,
    m.hire_date as "Mgr Hired"
from hr.employees e
left join hr.employees m on e.manager_id = m.employee_id
where (e.hire_date < m.hire_date);

-- Question 10. Create a view called EMPLOYEES_VU based on the employee numbers, employee names, and department 
-- numbers from the HR.EMPLOYEES table. Change the heading for the employee name to EMPLOYEE.
create view EMPLOYEE_UV as
select 
    employee_id,
    first_name || ' ' || last_name as EMPLOYEE,
    department_id
from hr.employees;
-- 10a. Display the contents of the EMPLOYEES_VU view 
select * from EMPLOYEE_UV;
-- 10b. Select the view name and text from the USER_VIEWS data dictionary view. 
select 
    view_name,
    text
from USER_VIEWS;
-- 10c. Using your EMPLOYEES_VU view, enter a query to display all employee names and department numbers. 
select 
    employee,
    department_id
from employee_uv;

-- Question 11. Create a view named DEPT50 that contains the employee numbers, employee last names, 
-- and department numbers for all employees in department 50. Label the view columns EMPNO, EMPLOYEE and DEPTNO. 
-- Do not allow an employee to be re-assigned to another department through the view.
create view DEPT50 as
select 
    employee_id as EMPNO,
    last_name as EMPLOYEE,
    department_id as DEPTNO
from hr.employees
where department_id = '50'; 
-- 11a. Display the structure and contents of DEPT50 view. 
select * from DEPT50;
-- 11b. Select the view name and text from the USER_VIEWS data dictionary view. 
select 
    view_name,
    text
from user_views;
-- 11c. Attempt to re-assign Matos to department 80 by doing an update command. 
update view DEPT50
set DEPTNO='80'
where EMPLOYEE='Matos';






