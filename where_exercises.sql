-- 1.) Created file and using employees database

-- 2.) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
use employees;
select * from employees
where first_name IN ('Irena', 'Vidya', 'Maya');

/* I selected all employees, told it to return all entries with those first names. 
   Number of records returned was 709 */


-- 3.) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?

use employees;
select * from employees
where first_name = 'Irena' 
or first_name = 'Vidya' 
or first_name = 'Maya';

 -- both yield the same of 709 results, if you don't use in, you can use or but put them all in separate lines. Records returned was 709, so it does match with question 2

-- 4.) Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
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
-- 4.) 441 records were returned for names Irena, Vidya, and Maya and who are male.
/* I told it to select all entries with either of those names, but they have to be male. */

-- 5.) Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.

select * from employees
where last_name like 'E%';

-- 5.) 7330 employees had a last name starting with 'E', the modulus indicates any character after.

-- 6.) Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. 
-- How many employees have a last name that ends with E, but does not start with E?

select * from employees
where last_name like 'E%'
or last_name like '%E';

select * from employees
where last_name like '%E'
and last_name not like 'E%';

-- 6.) 30723 employees have last names that start or end with an 'E',  and 23,393 employees have a last name that ends with an 'e' but does not start with an 'E'

-- 7.) Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E.
-- How many employees' last names end with E, regardless of whether they start with E?

-- starts and ends with an E
select * from employees
where last_name like 'E%' 
and last_name like '%E';

-- ends with an E, regardless of whether it starts with an E
select last_name from employees
where last_name like '%E';



-- 7.) 899 employees have a last name that starts with and ends with an 'E', and 24,292 employees have a last name that ends with an 'E'
/* The modulus is a wildcard, and it basically says any character here or there until you define a letter or word */


-- 8.) Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.

select * from employees
where hire_date between '1990-01-01' and '1999-12-31';

-- these are also yielding the same result 

select * from employees 
where hire_date like '199%';

-- The number of employees hired in the 90s is 135,214

-- 9.) Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.

select * from employees
where birth_date like '%12-25';

-- the number of employees born on Christmas day is 842

-- 10.) Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
select * from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25';

-- both yield the same result 

select * from employees
where hire_date like '199%' 
and birth_date like '%12-25';

-- 362 employees were hired in the 90s and has a birthday on Christmas day


-- 11.) Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.

select * from employees
where last_name like '%q%';

-- 1873 employees have a last name with the letter 'q' in it.

-- 12.) Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?

select * from employees where last_name like "%q%"
and last_name not like "%qu%";

-- 547 employees have a 'q' in their last name, without 'qu' being in it. 


