
-- 1.) I copied my contents of my previous exercise to this order_by_exercises. The answers to my previous exercise have a p at the end of the question number! 

-- 1p.) Created file and using employees database
use employees;
select * from employees
where first_name IN ('Irena', 'Vidya', 'Maya');

-- 2p.) Number of records returned was 709

use employees;
select * from employees
where first_name = 'Irena' 
or first_name = 'Vidya' 
or first_name = 'Maya';

-- both yield the same 

use employees;
select * from employees
where first_name like 'Irena' 
or first_name like 'Vidya' 
or first_name like 'Maya';
-- 3p.) Records returned was 709, so it does match with question 2
select * from employees
where first_name like 'Irena'
and gender = 'M' 
or first_name like 'Vidya' 
and gender = 'M'
or first_name like 'Maya'
and gender = 'M';

-- both of these codes yield the same result, one is way more efficient than the other 
select * from employees 
where (first_name like 'Irena'
	or first_name like 'Vidya'
	or first_name like 'Maya')
	and gender = 'M';
-- 4p.) 441 records were returned for names Irena, Vidya, and Maya and who are male.

select * from employees
where last_name like 'E%';

-- 5p.) 7330 employees had a last name starting with 'E'

select * from employees
where last_name like 'E%'
or last_name like '%E';

select * from employees
where last_name like '%E'
and last_name not like 'E%';

-- 6p.) 30723 employees have last names that start or end with an 'E',  and 23,393 employees have a last name that ends with an 'e' but does not start with an 'E'

select * from employees
where last_name like 'E%' 
and last_name like '%E';

select last_name from employees
where last_name like '%E';

-- 7p.) 899 employees have a last name that starts with and ends with an 'E', and 24,292 employees have a last name that ends with an 'E'

select * from employees
where hire_date between '1990-01-01' and '1999-12-31';

-- these are also yielding the same result 

select * from employees 
where hire_date like '199%';

-- 8p.) The number of employees hired in the 90s is 135,214

select * from employees
where birth_date like '%12-25';

-- 9p.) the number of employees born on Christmas day is 842
select * from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25';

-- both yield the same result 

select * from employees
where hire_date like '199%' 
and birth_date like '%12-25';

-- 10p.) 362 employees were hired in the 90s and has a birthday on Christmas day

select * from employees
where last_name like '%q%';

-- 11p.) 1873 employees have a last name with the letter 'q' in it.

select * from employees where last_name like "%q%"
and last_name not like "%qu%";

-- 12p.) 547 employees have a 'q' in their last name, without 'qu' being in it. 
-- 2.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

use employees;
select * from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
order by first_name asc;

-- 2.) Irena Reutenauer was the first and last name of my first person in the results. Vidya Simmen was the first and last name of the last person in the results. 
/* Same code as before, but I ordered it by first name in ascending order. I scrolled all the way down for
the last entry. It sorts by emoloyee number secondly. */
-- 3.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
use employees;
select * from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
order by first_name, last_name;

-- 3.) Irena Acton was the first and last name of the first entry in my results. Vidya Zweizig was the first and last name of my last entry in my results.
/* Now it orders by alphabetical order of the full name, because I asked it to order by first and last name */
-- 4.) Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
use employees;
select * from employees
where first_name IN ('Irena', 'Vidya', 'Maya')
order by last_name, first_name;

-- 4.) Irena Acton was the first and last name of the first entry in my results. Maya Zyda was the first and last name of my last entry in my results.

-- 5.) Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
select * from employees 
where last_name like 'E%'
and last_name like '%E'
order by emp_no;

-- 5.) 899 employees returned. The first employee number is 10021 with a first and last name of Ramzi Erde. Last employee number is 499648 with a first and last name of Tadahiro Erde.

-- 6.) Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.
select * from employees
where last_name like 'E%'
and last_name like '%E'
order by hire_date desc;

-- 6.) 899 employees returned. The first employee number(and newest hire of this category) has a first and last name of Teiji Eldridge. The name of the oldest employee is Sergi Erde.

-- 7.) Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.
select * from employees
where hire_date like '199%' 
and birth_date like '%12-25'
order by birth_date ASC, hire_date desc;

-- 7.) 362 employees returned. Name of the oldest employee who was hired last is Khun Bernini. Name of the youngest employee who was hired first is Douadi Pettis.
/* I let the oldest people (by birth date) show up first, along with the most recent hire date. */