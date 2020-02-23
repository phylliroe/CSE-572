-- Name: Andrew Loop-Perez
-- ID: 006198799
-- Course: CSE 572 Winter 2020
-- Assignment: Lab #5

-- 1. List all project names and the managers in charge of the projects
select 
    p.projname,
    e.fname || ' ' || e.lname as MANAGER
from proj p
left join emp e on e.deptNo = p.DeptNum
where e.position = 'Manager';

-- 2. Calculate total hours to each project
select 
    p.projname as PROJECT,
    sum(ep.hoursworked) as TOTAL_HOURS
from proj p
join emp_proj ep on ep.projno = p.projnumber
group by p.projname;

-- 3. Create a view to display the hourly pay rate for each employee
create view HOURLY_PAY as 
select 
    empNo,
    fname || ' ' || lname as EMPLOYEE,
    round(salary/408,2) as HOURLY_RATE
from emp;

select * from hourly_pay;

--4. Find the total labor cost per employee, per project
select 
    e.empno,
    e.fname || ' ' || e.lname as EMPLOYEE,
    p.projname as PROJECT,
    ep.hoursworked * (select hourly_rate from hourly_pay where hourly_pay.empno = ep.empno) as TOTAL_COST
from emp e
join proj p on p.deptnum = e.deptno
join emp_proj ep on ep.empno = e.empno;

-- 5. Add columns to the EMP table for the employee's birth date and hire date
alter table emp
add BIRTH_DATE varchar(255);

alter table emp
add HIRE_DATE varchar(255);

update emp
set birth_date = '04/30/1995', hire_date = '05/01/2010'
where empno ='1000';

update emp
set birth_date = '12/31/1986', hire_date = '01/02/2018'
where empno ='1007';

update emp
set birth_date = '07/12/1964', hire_date = '10/15/2014'
where empno ='2002';

update emp
set birth_date = '02/28/1976', hire_date = '06/15/2009'
where empno ='1760';

update emp
set birth_date = '09/10/1990', hire_date = '09/02/2011'
where empno ='1740';

update emp
set birth_date = '06/25/1980', hire_date = '04/01/2013'
where empno ='2060';

update emp
set birth_date = '05/05/1999', hire_date = '08/01/2019'
where empno ='2000';

update emp
set birth_date = '01/24/1993', hire_date = '07/15/2012'
where empno ='1444';

-- 6 Create a new table named emp_proj_overtime
create table emp_proj_overtime (
    empno number(4,0),
    projno number(4, 0),
    hourOt number(6, 2),
    primary key(empno, projno)
);

update emp_proj
set hoursworked = 250
where empno = 1000 and projno = 30;

update emp_proj
set hoursworked = 150
where empno = 2002 and projno = 10;

-- 7. Develop a trigger to track overtime when an employee exceeds 100 hours worked on a project
create or replace trigger overtime_trigger
after insert or update of hoursworked on emp_proj
referencing old as old new as new
for each row when (new.hoursworked > 100)
begin
    insert into emp_proj_overtime(empno, projno, hourot) values(:new.empno, :new.projno, :new.hoursworked - 100);    
    
    exception when dup_val_on_index then
        update emp_proj_overtime epo
        set epo.hourot = :new.hoursworked - 100
        where epo.empno = :old.empno and epo.projno = :old.projno;
    commit;
end;
/

-- 8. Modify the query from question 4 to account for overtime pay
select 
    e.empno,
    e.fname || ' ' || e.lname as EMPLOYEE,
    p.projname as PROJECT,
    (
    case when ep.hoursworked > 100 then
        ( 100 * (select hourly_rate from hourly_pay where hourly_pay.empno = ep.empno) ) +
        ((ep.hoursworked - 100) * (2 * (select hourly_rate from hourly_pay where hourly_pay.empno = ep.empno)))
    else 
        ep.hoursworked * (select hourly_rate from hourly_pay where hourly_pay.empno = ep.empno)
    end) as TOTAL_COST
from emp e
join proj p on p.deptnum = e.deptno
join emp_proj ep on ep.empno = e.empno;


select 
    e.empno,
    e.fname || ' ' || e.lname as EMPLOYEE,
    p.projname as PROJECT,
    (
    case when ep.hoursworked > 100 then
        (100 * (select hourly_rate from hourly_pay where hourly_pay.empno = ep.empno)) +
        ((select hourot from emp_proj_overtime epo where epo.empno = ep.empno) * (2 * (select hourly_rate from hourly_pay where hourly_pay.empno = ep.empno)))
    else 
        ep.hoursworked * (select hourly_rate from hourly_pay where hourly_pay.empno = ep.empno)
    end) as TOTAL_COST
from emp e
join proj p on p.deptnum = e.deptno
join emp_proj ep on ep.empno = e.empno;



select * from emp;
select * from dept;
select * from proj;
select * from emp_proj;

select * from hr.employees;

select * from emp_proj_overtime;

drop table emp_proj_overtime;

drop trigger overtime_trigger;









