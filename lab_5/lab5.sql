-- 2. Create tables with constraints 
create table EMP (
    empNo number(4, 0) primary key,
    fname varchar(255),
    lname varchar(255),
    address varchar(255),
    sex char(8) check (sex = 'M' or sex = 'F'),
    salary number(6,0) check (salary >= 12000),
    position varchar(255),
    deptNo number(2, 0) not null
);

create table DEPT (
    deptNumber number(2,0) primary key,
    deptName varchar(255),
    Mgr number(4, 0) not null
);

create table PROJ (
    projNumber number(2, 0) unique,
    projName varchar(255),
    deptNum number(2, 0) not null
);

create table EMP_PROJ (
    empNo number(4, 0),
    projNo number(2, 0),
    hoursWorked number(4, 2), 
    primary key (empNo, projNo)
);


-- 4. Insert data into tables using CSV to SQL generated statements 
-- emp insert
INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (1000,'Steven','King','731 Fondren, Houston TX','M',30000,'Programmer',60);

INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (1007,'Diana','Lorentz','638 Voss, Bellaire, TX','F',24000,'Clerk',20);

INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (2002,'Pat','Fay','3321 Castle, Spring, TX','F',15000,'Sales  Representative',80);

INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (1760,'Jonathan','Taylor','561 Rice, Houston, TX','M',60000,'Manager',20);

INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (1740,'Ellen','Abel','890 Stone, Houston, TX','F',65000,'Manager',60);

INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (2060,'William','Gietz','450 Berry, Bellaire, TX','M',65000,'Manager',80);

INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (2000,'Jennifer','Whalen','980 Fire Oak, Humble, TX','F',28000,'Clerk',60);

INSERT INTO emp(empNo,fname,lname,address,sex,salary,position,deptNo) 
VALUES (1444,'Peter','Vargas','975 Dallas, Houston, TX','M',20000,'Sales  Representative',80);


-- dept insert
INSERT INTO dept(deptNumber,deptName,Mgr) 
VALUES (20,'Marketing',1760);

INSERT INTO dept(deptNumber,deptName,Mgr)
VALUES (60,'IT',1740);

INSERT INTO dept(deptNumber,deptName,Mgr)
VALUES (80,'Sales',2060);


-- proj insert
INSERT INTO proj(projNumber,projName,deptNum) 
VALUES (10,'Product X',20);

INSERT INTO proj(projNumber,projName,deptNum) 
VALUES (20,'Product Y',20);

INSERT INTO proj(projNumber,projName,deptNum)
VALUES (30,'Computerization',60);

INSERT INTO proj(projNumber,projName,deptNum) 
VALUES (40,'Product Z',80);

INSERT INTO proj(projNumber,projName,deptNum) 
VALUES (50,'Mobile Apps',60);


-- 6. Foreign keys
-- EMP
alter table emp
add constraint department
foreign key (deptNo) references dept(deptNumber);

-- DEPT
alter table dept
add constraint manager_empNo
foreign key (mgr) references emp(empNo);

-- PROJ
alter table proj
add constraint dept_number
foreign key (deptnum) references dept(deptnumber);

-- EMP_PROJ
alter table emp_proj
add constraint emp_number
foreign key (empNo) references emp(empNo);

alter table emp_proj
add constraint proj_number
foreign key (projNo) references proj(projNumber);

--7. 
insert into emp_proj 
values (&empNo, &projNo, &hoursWorked);

-- 9. 
alter table emp
add email varchar(255);

-- 10
-- This statement throws an error because there is no table named "EMPLOYEES"
-- Missing a value for the SEX colum
-- The values for the SALARY and POSITION columns are in the wrong order
-- Missing a value for the EMAIL column that was added
-- Salary value does not meet the constraint
-- The statement does not accound for the foreign key constraint
insert into employees values (1172, 'joe', 'Calvert', '672 White Pine, Austin, TX', 'X', 10000, 10);

-- 11
-- The corrected version of the statement above
-- The value for DEPTNO in the new entry is null since so department number 10 exists in the DEPT table
insert into emp
values (1172, 'joe', 'Calvert', '672 White Pine, Austin, TX', 'M', 12000, 'X', 
(select deptNumber from dept where deptNumber=10), null);


--=======================================
-- LAB 5
--=======================================

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


--

select * from emp;
select * from dept;
select * from proj;
select * from emp_proj;


drop view hourly_pay;



















