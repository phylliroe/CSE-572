-- Name: Andrew Loop-Perez
-- ID: 006198799
-- Course: CSE 572
-- Assignment: Lab #2

-- 1. Select all rows in the Departments table
SELECT * FROM HR.DEPARTMENTS;

-- 2a. Select all employees with a salary greater than 15,000
SELECT * FROM HR.EMPLOYEES
WHERE SALARY > 15000;

-- 2b. Select employees hired between Janurary 1, 2002 and January 1, 2005
SELECT * FROM HR.EMPLOYEES
WHERE HIRE_DATE BETWEEN '1-JAN-02' AND '1-JAN-05';

-- 2C Select emplyoees whose phone number does not start with 515
SELECT * FROM HR.EMPLOYEES
WHERE PHONE_NUMBER NOT LIKE '515.%';

-- 3. List the names of the emplyoees in the finance department
-- Format their names as "firstname last name" and order them alphabetically
SELECT FIRST_NAME || ' ' || LAST_NAME FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = '100'
ORDER BY FIRST_NAME;

--4. List the city, state, and country name for all locations in the Asia region
SELECT CITY, STATE_PROVINCE, COUNTRY_ID FROM HR.LOCATIONS
WHERE COUNTRY_ID IN (SELECT COUNTRY_ID FROM HR.COUNTRIES WHERE REGION_ID = '3');

-- 5. List the locations that have no state or province specified
SELECT * FROM HR.LOCATIONS
WHERE STATE_PROVINCE IS NULL;

-- 6. Create a query to display the highest, lowest, sum, and average salary of all employees
-- Label the columns Maxiumum, Minimum, Sum, and Average
SELECT MAX(SALARY) AS Maximum, 
       MIN(SALARY) AS Minimum, 
       SUM(SALARY) AS Sum, 
       AVG(SALARY) AS Average
FROM HR.EMPLOYEES;

-- 7 Orcale dual default table 





