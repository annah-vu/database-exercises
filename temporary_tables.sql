-- 1.) Using the example from the lesson, re-create the employees_with_departments table.

USE florence02;
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT employees.employees.emp_no, employees.employees.first_name, employees.employees.last_name, employees.dept_emp.dept_no, employees.departments.dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);



SELECT * FROM employees_with_departments;

-- 1a.) Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns
ALTER TABLE employees_with_departments ADD full_name VARCHAR(100);

SELECT * FROM employees_with_departments;

-- 1b.) Update the table so that full name column contains the correct data
UPDATE employees_with_departments
SET full_name = concat(first_name, ' ', last_name);

SELECT * FROM employees_with_departments;

-- 1c.) Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

SELECT * FROM employees_with_departments;

-- 1d.) What is another way you could have ended up with this same table? We can create full_name in original query 


-- 2.) Create a temporary table based on the payment table from the sakila database.
USE florence02;
CREATE TEMPORARY TABLE sakila_payment AS
SELECT * FROM sakila.payment;

SELECT * FROM sakila.payment;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

SELECT * FROM sakila_payment;

ALTER TABLE sakila_payment MODIFY amount DECIMAL (9,0);

UPDATE sakila_payment SET amount = amount * 100;

SELECT * FROM sakila_payment;

-- 3.) Find out how the current average pay in each department compares to the overall, historical average pay.
-- IN order TO make the comparison easier, you should USE the Z-score FOR salaries. 
-- IN terms of salary, what IS the best department RIGHT now TO WORK FOR? The worst?
SELECT * FROM employees_with_departments
JOIN employees.salaries ON employees_with_departments.emp_no = employees.salaries.emp_no
WHERE employees.salaries.to_date > curdate();

SELECT dept_name, AVG(employees.salaries.salary) AS average_salary
FROM employees_with_departments
JOIN employees.salaries ON employees_with_departments.emp_no = employees.salaries.emp_no
WHERE employees.salaries.to_date > curdate()
GROUP BY dept_name;

SELECT *
FROM employees_with_departments
JOIN employees.salaries ON employees_with_departments.emp_no = employees.salaries.emp_no
WHERE employees.salaries.to_date > curdate();

SELECT dept_name, AVG(employees.salaries.salary) AS c_average_salary
FROM employees_with_departments
JOIN employees.salaries ON employees_with_departments.emp_no = employees.salaries.emp_no
WHERE employees.salaries.to_date > curdate()
GROUP BY dept_name;
 
 -- 
SELECT AVG(employees.salaries.salary) AS h_average_salary
FROM employees_with_departments
JOIN employees.salaries ON employees_with_departments.emp_no = employees.salaries.emp_no;

CREATE TEMPORARY TABLE salary_comparison AS(
SELECT dept_name, AVG(employees.salaries.salary) AS c_average_salary
FROM employees_with_departments
JOIN employees.salaries ON employees_with_departments.emp_no = employees.salaries.emp_no
WHERE employees.salaries.to_date > curdate()
GROUP BY dept_name);

SELECT *
FROM salary_comparison;

ALTER TABLE salary_comparison ADD h_average_salary INT(255);

ALTER TABLE salary_comparison
MODIFY h_average_salary DECIMAL(10,4);

UPDATE salary_comparison 
SET h_average_salary = 63805.4005;

SELECT *, (c_average_salary - h_average_salary)/ 16904.82828800014 AS z_score
FROM salary_comparison;
-- 
USE employees;
SELECT stddev(salary)
FROM salaries;

USE florence02;
SELECT * FROM salary_comparison;

-- The best department to work for, pay-wise, is Sales. They have a zscore of 1.48 which means they're the fastest growing in raises of all departments. The worst would be human resources as it seems to be very stagnant/getting worse. 

