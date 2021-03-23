-- 1. opened sequel pro and logged in
-- 2. saved my work 
-- 3. use employees db 

SHOW DATABASES;
use `employees`;

-- list all tables in the db
SHOW TABLES;
-- the kinds of data types I'm seeing are numeric (mostly int), string (mostly varchar and char), and date. 

-- Numeric would be salaries for the amount they're making, dept management (int) as the departments are labeled by numbers, titles
-- string would be department names, titles, and their employee name entires on the employees file. 
-- date would be date employed, titles on the date they received that title till the time they held it, the latest date they are employed, employees birth dates on the employees tables, and salaries also has a date column to show the time period in which that income was made. 

SHOW CREATE TABLE dept_manager;
SHOW CREATE TABLE titles;
SHOW CREATE TABLE employees;
SHOW CREATE TABLE titles

-- relationship between department and employees is that all employees are assigned to a particular department, it cannot be null, they have to be working in one of those departments listed.
SHOW CREATE TABLE dept_emp



-- This is the SQL that made the dept manager table
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

