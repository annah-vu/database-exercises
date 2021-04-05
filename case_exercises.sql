-- Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

/* I selected the required criteria, then joined dept_emp and employees on emp_no to get dept_no and to_date. Then I used a case statement to tell it to return a 1 if the 
employee was still with the company, or a 0 if not.*/
SELECT * FROM employees;

SELECT *
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no;

SELECT employees.emp_no, dept_no, hire_date, to_date,
CASE
WHEN to_date LIKE '9999-01-01' THEN '1'
ELSE '0'
END AS is_current_employee
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no;

-- 2.) Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
/* We tried experimenting with a shortcut to no avail YET! I made 26 separate lines and told it which group it was under.*/
SELECT *
FROM employees;

SELECT first_name, last_name
FROM employees; 

SELECT first_name, last_name,
CASE 
WHEN LEFT(last_name, 1) IN('a', 'b', 'c', 'd', 'e', 'f', 'g', 'h') THEN 'A-H'
WHEN LEFT(last_name,1) IN ('i', 'j', 'k', 'l', 'm', 'n', 'p', 'q') THEN 'I-Q'
WHEN LEFT(last_name,1) IN ('r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z') THEN 'R-Z'
END AS 'alpha_group'
FROM employees;

SELECT first_name, last_name,
CASE 
WHEN last_name LIKE 'a%' THEN 'A-H'
WHEN last_name LIKE 'b%' THEN 'A-H'
WHEN last_name LIKE 'c%' THEN 'A-H'
WHEN last_name LIKE 'd%' THEN 'A-H'
WHEN last_name LIKE 'e%' THEN 'A-H'
WHEN last_name LIKE 'f%' THEN 'A-H'
WHEN last_name LIKE 'g%' THEN 'A-H'
WHEN last_name LIKE 'h%' THEN 'A-H'
WHEN last_name LIKE 'I%' THEN 'I-Q'
WHEN last_name LIKE 'j%' THEN 'I-Q'
WHEN last_name LIKE 'k%' THEN 'I-Q'
WHEN last_name LIKE 'l%' THEN 'I-Q'
WHEN last_name LIKE 'm%' THEN 'I-Q'
WHEN last_name LIKE 'n%' THEN 'I-Q'
WHEN last_name LIKE 'o%' THEN 'I-Q'
WHEN last_name LIKE 'p%' THEN 'I-Q'
WHEN last_name LIKE 'q%' THEN 'I-Q'
WHEN last_name LIKE 'r%' THEN 'R-Z'
WHEN last_name LIKE 's%' THEN 'R-Z'
WHEN last_name LIKE 't%' THEN 'R-Z'
WHEN last_name LIKE 'u%' THEN 'R-Z'
WHEN last_name LIKE 'v%' THEN 'R-Z'
WHEN last_name LIKE 'w%' THEN 'R-Z'
WHEN last_name LIKE 'x%' THEN 'R-Z'
WHEN last_name LIKE 'y%' THEN 'R-Z'
WHEN last_name LIKE 'z%' THEN 'R-Z'
END AS 'alpha_group'
FROM employees;

-- 3.) How many employees (current or previous) were born in each decade?
-- 1952 is the oldest birth year, 1965 is the newest birth_year
-- Anyone born in the 1950s will be categorized in the 1950s bin 
-- Anyone born in the 1960s will be categorized in the 1960s bin 
-- I set the count as employees_per_decade and grouped by birth_decade
SELECT birth_date
FROM employees
ORDER BY birth_date;

SELECT 
CASE 
WHEN birth_date LIKE '195%' THEN '1950s'
WHEN birth_date LIKE '196%' THEN '1960s'
ELSE 'youngins'
END AS birth_decade,
count(*) AS employees_per_decade
FROM employees
GROUP BY birth_decade;