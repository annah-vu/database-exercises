USE employees;

#1.) Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT hire_date
FROM employees
WHERE emp_no = 101010;

SELECT concat(first_name, ' ', last_name) AS full_name, hire_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE hire_date IN (SELECT hire_date
FROM employees
WHERE emp_no = 101010)
AND to_date > curdate();

SELECT *
FROM `dept_emp`
WHERE from_date IN(SELECT hire_date
FROM `employees` WHERE emp_no = 101010)
AND to_date > curdate();


/* I selected all entries from the department employee table, because it also has a 'hire-date' which
is called 'from-date' but it has that 'to-date' that the employees table does not have.

I sub-queryed from the employees table to select the hire date of emp no 101010 */ 
#2.) Find all the titles ever held by all current employees with the first name Aamod.
SELECT first_name
FROM employees
WHERE first_name = 'Aamod';

SELECT title
FROM employees
JOIN titles ON employees.emp_no = titles.emp_no
WHERE first_name IN (SELECT first_name
FROM employees
WHERE first_name = 'Aamod')
AND to_date > curdate()
GROUP BY title;

SELECT title
FROM titles
WHERE emp_no IN(SELECT emp_no
FROM employees
WHERE first_name = 'Aamod')
AND to_date > curdate()
GROUP BY title;

-- This is Ray's doing, but I didn't take into account its all historical roles by current Aamods. 
SELECT
      t.title AS 'Titles Held by Aamods',
      COUNT(t.title) AS 'Total Aamods Who Held Title'
FROM titles AS t
WHERE
      t.emp_no IN
      (
            SELECT
                  e.emp_no
            FROM employees AS e
            JOIN salaries AS s
                  ON e.emp_no = s.emp_no
                        AND s.to_date > CURDATE()
            WHERE
                first_name LIKE 'Aamod'
      )
GROUP BY
      t.title
;

/* I selected titles from the titles table and searched by emp_no in the employees table for any persons with
the first name of Aamod. I grouped it by title so I could only get unique values.
     */

#3.) How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. 91,479 employees do not work for the company anymore. 
SELECT to_date 
FROM dept_emp
WHERE to_date < curdate();

SELECT concat(first_name, ' ',last_name) AS full_name, hire_date, dept_emp.to_date
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
WHERE to_date IN (SELECT to_date 
FROM dept_emp
WHERE to_date < curdate())

SELECT *
FROM dept_emp 
WHERE to_date IN(SELECT to_date FROM dept_emp 
WHERE to_date < curdate());

select count(*) as number_of_non employees from employees where 
emp_no not in (select emp_no from dept_emp where to date like '9999%');

-- 59900 do not work at this company anymore.
/* I used the dept_emp table which has the employees to and from dates to see which employees have 
a to-date that is less than where we are today   */

#4.) Find all the current department managers that are female. List their names in a comment in your code.
SELECT *
FROM employees
JOIN dept_manager ON employees.emp_no = dept_manager.emp_no
JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE gender IN (SELECT gender FROM employees
WHERE gender = 'F')
AND to_date > curdate();

SELECT first_name, last_name, gender, to_date
FROM dept_manager
JOIN employees USING(emp_no)
WHERE gender IN (
	SELECT gender 
	FROM employees
	WHERE gender = 'F')
AND to_date > curdate();


SELECT first_name, last_name, gender, to_date
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
WHERE gender IN (
	SELECT gender
	FROM employees
	WHERE gender = 'F')
AND to_date > curdate();

-- heres the way to do it without joins

SELECT first_name, last_name FROM `employees`
WHERE emp_no IN(SELECT emp_no FROM dept_manager
WHERE to_date > curdate())
AND gender = 'F';

-- The names are Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil.
-- I selected first and last names from the employees table and then used the dept_manager
-- table to figure out who was still a current manager. Then I found the ones that were women.

-- 5.) Find ALL the employees who currently have a higher salary THAN the companies overall, historical average salary.

SELECT AVG(salary) FROM salaries;

SELECT *
FROM salaries
WHERE salary > (SELECT AVG(salary) FROM salaries)
AND to_date > curdate();

/*I selected all salaries and used it to find which ones were greater than the average salary 
from the salaries table. I also made sure that the salaries that were selected were current. It returned 154,543 */

-- 6.) How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT DISTINCT emp_no
FROM salaries
WHERE salary >=(SELECT max(salary) - stddev(salary) FROM salaries
WHERE to_date > curdate())
AND to_date > curdate();

SELECT salary
FROM salaries
WHERE salary >=(SELECT max(salary) - stddev(salary) FROM salaries
WHERE to_date > curdate())
AND to_date > curdate();


SELECT (SELECT count(salary)
FROM salaries
WHERE salary > (
SELECT max(salary) - STDDEV(salary)
FROM salaries
WHERE to_date > curdate())
AND to_date > curdate())
/
(SELECT count(salary)
FROM salaries
WHERE to_date > curdate()) *100;

/* I began by selecting distinct employees from the salaries table. I wanted to make sure that their salary
was greater than the value  of the max salary minus the standard deviation. I also made sure the entries being
evaluated were current. To calculate the percentage, I took the count of current salaries
meeting the threshold and divided it by total number of current salaries. I multiplied it by 100 to get
the percentage. .0346 percent