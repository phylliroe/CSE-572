-- Name: Andrew Loop-Perez
-- ID: 006198799
-- Course: CSE 572
-- Assignment: Lab #4

create table EMP (
    empNo number(4, 0) primary key,
    fname varchar(255),
    lname varchar(255),
    address varchar(255),
    sex char(8) check (sex = 'M' or sex = 'F'),
    salary number(6,0) check (salary >= 12000),
    position varchar(255),
    deptNo number(2, 0)
);

create table DEPT (
    deptNumber number(4,0) primary key,
    deptName varchar(255),
    Mgr varchar(255),
    projNumber number(2,0) unique
);

create table PROJ (
    projNumber number(2, 0) unique,
    projName varchar(255),
    deptNum number(2, 0)
);

create table EMP_PROJ (
    empNo number(4, 0) unique,
    projNo number(2, 0) unique,
    hoursWorked number(4, 0), 
    primary key (empNo, projNo)
);

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


select * from emp;
select * from dept;
select * from proj;
select * from emp_proj;

drop table emp;
drop table dept;
drop table proj;
drop table emp_proj;

