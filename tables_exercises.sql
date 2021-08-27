-- 1. opened sequel pro and logged in
-- 2. saved my work in file named tables_exercises.sql
-- 3. use employees db 

SHOW DATABASES;
use `employees`;

-- 4. list all tables in the db
SHOW TABLES;


-- 5. Explore the employees table. What different data types are present on this table?
DESCRIBE employees;
/* the kinds of data types I'm seeing are numeric (mostly int), string (mostly varchar and char), enum and date. */


-- 6. Numeric data types would be salaries for the amount they're making, dept management (int) as the departments are labeled by numbers, titles
-- 7. string data types would be department names, titles, and their employee name entires on the employees file. 
-- 8. date data types would be date employed, titles on the date they received that title till the time they held it, the latest date they are employed, employees birth dates on the employees tables, and salaries also has a date column to show the time period in which that income was made. 

SHOW CREATE TABLE dept_manager;
SHOW CREATE TABLE titles;
SHOW CREATE TABLE employees;
SHOW CREATE TABLE titles

-- 9. relationship between department and employees is that all employees are assigned to a particular department, it cannot be null, they have to be working in one of those departments listed. They both contain emp_no.
SHOW CREATE TABLE dept_emp



-- 10 .This is the SQL that made the dept manager table
   CREATE TABLE `dept_manager` (
  `emp_no` int(11) NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

