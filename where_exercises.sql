-- 1.) Created file and using employees database
use employees;
select * from employees
where first_name IN ('Irena', 'Vidya', 'Maya');

-- 2.) Number of records returned was 709

use employees;
select * from employees
where first_name like 'Irena' 
or first_name like 'Vidya' 
or first_name like 'Maya';

-- 3.) Records returned was 709, so it does match with question 2
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

select * from employees
where last_name like 'E%';

-- 5.) 7330 employees had a last name starting with 'E'

select * from employees
where last_name like 'E%'
or last_name like '%E';

select * from employees
where last_name like '%E'
and last_name not like 'E%';

-- 6.) 30723 employees have last names that start or end with an 'E',  and 23,393 employees have a last name that ends with an 'e' but does not start with an 'E'

select * from employees
where last_name like 'E%' 
and last_name like '%E';

select last_name from employees
where last_name like '%E';

-- 7.) 899 employees have a last name that starts with and ends with an 'E', and 24,292 employees have a last name that ends with an 'E'

select * from employees
where hire_date between '1990-01-01' and '1999-12-31';

-- these are also yielding the same result 

select * from employees 
where hire_date like '199%';

-- 8.) The number of employees hired in the 90s is 135,214

select * from employees
where birth_date like '%12-25';

-- 9.) the number of employees born on Christmas day is 842
select * from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%12-25';

-- both yield the same result 

select * from employees
where hire_date like '199%' 
and birth_date like '%12-25';

-- 10.) 362 employees were hired in the 90s and has a birthday on Christmas day

select * from employees
where last_name like '%q%';

-- 11.) 1873 employees have a last name with the letter 'q' in it.

select * from employees where last_name like "%q%"
and last_name not like "%qu%";

-- 12.) 547 employees have a 'q' in their last name, without 'qu' being in it. 


