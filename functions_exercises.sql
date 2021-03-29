####### Copied the order_by exercises, keep scrolling for my functions exercises! 

-- 2.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

USE employees;
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name ASC;

-- 2.) Irena Reutenauer was the first and last name of my first person in the results. Vidya Simmen was the first and last name of the last person in the results. 

-- 3.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
USE employees;
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name;

-- 3.) Irena Acton was the first and last name of the first entry in my results. Vidya Zweizig was the first and last name of my last entry in my results.

-- 4.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
USE employees;
SELECT * FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name;

-- 4.) Irena Acton was the first and last name of the first entry in my results. Maya Zyda was the first and last name of my last entry in my results.

-- 5.) Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT * FROM employees 
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY emp_no;

-- 5.) 899 employees returned. The first employee number is 10021 with a first and last name of Ramzi Erde. Last employee number is 499648 with a first and last name of Tadahiro Erde.

-- 6.) Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.
SELECT * FROM employees
WHERE last_name LIKE 'E%'
AND last_name LIKE '%E'
ORDER BY hire_date DESC;

-- 6.) 899 employees returned. The first employee number(and newest hire of this category) has a first and last name of Teiji Eldridge. The name of the oldest employee is Sergi Erde.

-- 7.) Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.
SELECT * FROM employees
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%12-25'
ORDER BY birth_date ASC, hire_date DESC;

-- 7.) 362 employees returned. Name of the oldest employee who was hired last is Khun Bernini. Name of the youngest employee who was hired first is Douadi Pettis.


#########End of Order By Exercises
USE employees;
-- 2.) Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name. I have two ways to do it here.
SELECT *,
concat (first_name, ' ', last_name) full_name
FROM `employees`
WHERE last_name LIKE 'e%e'
ORDER BY full_name;

SELECT concat(first_name, ' ', last_name) AS 'full_name'
FROM employees
WHERE last_name LIKE 'e%e';


-- 3.) Convert the names produced in your last query to all uppercase. Two ways to do it here.
SELECT *,
concat (upper(first_name), ' ', upper(last_name)) AS full_name
FROM `employees`
WHERE last_name LIKE 'e%e' 
ORDER BY (full_name);

SELECT upper(concat(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%e';


-- 4.) Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT *,
DATEDIFF (CURDATE(), hire_date) AS 'Days Worked'
FROM `employees`
WHERE hire_date LIKE '199%' 
AND birth_date LIKE '%12-25';


-- 5.) Find the smallest and largest current salary from the salaries table.

SELECT min(salary) FROM salaries
WHERE to_date LIKE '9999%';
  # The smallest current salary is 38,623
SELECT max(salary) FROM salaries
WHERE to_date LIKE '9999%';
  # the highest current salary is 158,220


-- 6.) Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like: 

SELECT *,
lower(concat(substr(first_name, 1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS username
FROM employees;
