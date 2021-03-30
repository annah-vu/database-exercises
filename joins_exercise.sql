# Using Join/Inner Join

USE join_example_db;
SELECT * FROM roles, users;
SELECT users.name AS user_name, roles.name AS role_name
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
JOIN roles ON users.role_id = roles.id;


#Using left join
USE join_example_db;
SELECT * FROM roles, users;
SELECT users.name AS user_name, roles.name AS role_name
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
LEFT JOIN roles ON users.role_id = roles.id;

#Using right join
USE join_example_db;
SELECT * FROM roles, users;
SELECT users.name AS user_name, roles.name AS role_name
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

SELECT * FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

#Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT roles.name AS role_name, count(users.id)
FROM users
RIGHT JOIN roles ON users.role_id = roles.id
GROUP BY role_name;

## Start of Next Exercise
# 2.) Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

USE employees;
SELECT first_name, last_name, to_date, departments.dept_name, dept_manager.dept_no
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE to_date > curdate();

SELECT * 
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE to_date > curdate();

SELECT concat(employees.first_name, ' ', employees.`last_name`) AS full_name, departments.dept_name
FROM `employees`
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE to_date > curdate();

# 3.) Find the name of all departments currently managed by women.
SELECT d.dept_name AS 'Department Name', 
       CONCAT(e.first_name, ' ', e.last_name) AS 'Department Manager'
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no 
    AND to_date > CURDATE()
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE e.gender = 'F'
ORDER BY d.dept_name;

SELECT departments.dept_name AS 'Department Name',
concat(employees.first_name, ' ', employees.last_name) AS 'Department Manager'
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_n
AND to_date > curdate()
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE employees.gender = 'F';

SELECT concat(employees.first_name, ' ', employees.`last_name`) AS full_name, departments.dept_name
FROM `employees`
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE to_date > curdate() AND employees.gender = 'F';


#4.) Find the current titles of employees currently working in the Customer Service department.
SELECT titles.title AS Title, 
       COUNT(titles.title) AS Count
FROM titles
JOIN dept_emp AS de ON de.emp_no = titles.emp_no 
    AND de.to_date > CURDATE() 
    AND titles.to_date > CURDATE()
JOIN departments AS d ON d.dept_no = de.dept_no 
    AND d.dept_name = 'Customer Service'
GROUP BY titles.title;

SELECT title, count(title) 
FROM titles
JOIN dept_emp ON dept_emp.emp_no = titles.emp_no 
    AND dept_emp.to_date > CURDATE() 
    AND titles.to_date > CURDATE()
JOIN departments ON departments.dept_no = dept_emp.dept_no 
    AND departments.dept_name = 'Customer Service'
GROUP BY titles.title;

#5.) Find the current salary of all current managers.

SELECT * 
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN salaries ON employees.emp_no = salaries.emp_no
WHERE dept_manager.to_date > curdate();

SELECT concat(employees.first_name, ' ', employees.`last_name`) AS full_name, departments.dept_name, salaries.salary
FROM `employees`
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
JOIN salaries ON dept_manager.emp_no = salaries.emp_no
WHERE dept_manager.to_date > curdate() AND salaries.to_date > curdate();

#6.)Find the number of current employees in each department.

SELECT dept_emp.dept_no, dept_name, count(employees.emp_no) AS number_of_employees
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > curdate()
GROUP BY dept_emp.dept_no;




#7.) Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, AVG(salaries.salary) AS average_salary
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE salaries.to_date > curdate() AND dept_emp.to_date > curdate()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;


#8.) Who is the highest paid employee in the Marketing department?
SELECT first_name, last_name, salaries.salary
FROM employees
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN dept_emp ON salaries.emp_no = dept_emp.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE salaries.to_date > curdate() AND dept_emp.to_date > curdate() AND dept_name = 'Marketing'
ORDER BY salaries.salary DESC
LIMIT 1;

#9.) Which current department manager has the highest salary?

SELECT first_name, last_name, salaries.salary, departments.dept_name
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
JOIN dept_manager ON salaries.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE salaries.to_date > curdate() AND dept_manager.to_date > curdate()
ORDER BY salaries.salary DESC
LIMIT 1;

