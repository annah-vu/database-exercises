-- 1._ Create a new file named group_by_exercises.sql

-- 2.) In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
       ## There are 7 unique titles
 SELECT DISTINCT (title)
 FROM titles;
 
 -- 3.) Write a query to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
       ## This query will give you a list of all unique last names of all employees that start and end with the letter 'E' There are 5 of them.
 SELECT last_name FROM `employees`
 WHERE last_name LIKE 'E%'
 AND last_name LIKE '%E'
 GROUP BY last_name;
 
 SELECT last_name FROM employees
 WHERE last_name LIKE 'E%E'
 GROUP BY last_name;
 
 -- 4.) Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
        ## This query will give you unique combinations of first and last names of all employees whose last names start and ends with an 'E', there are 846 unique combinations!
 
 SELECT first_name, last_name FROM employees
 WHERE last_name LIKE 'E%'
 AND last_name LIKE '%E'
 GROUP BY first_name, last_name;
 
 -- 5.) Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
        ## The names are Chleq, Lindqvist, and Qiwen
 SELECT last_name FROM `employees`
 WHERE last_name LIKE '%q%'
 AND last_name NOT LIKE '%qu%'
 GROUP BY last_name;
 
-- 6.) Add a COUNT() to your results (the query above) and use ORDER BY to make it easier to find employees whose unusual name is shared with others.
SELECT last_name, COUNT(last_name) FROM `employees`
 WHERE last_name LIKE '%q%'
 AND last_name NOT LIKE '%qu%'
 GROUP BY last_name
 ORDER BY count(last_name);
 
 SELECT last_name, first_name, COUNT(last_name) FROM `employees`
 WHERE last_name LIKE '%q%'
 AND last_name NOT LIKE '%qu%'
 GROUP BY last_name, first_name
 ORDER BY count(last_name)DESC;
 ## Not sure which code it wants as the question can be interpreted multiple ways. :( The first block of code shows you how many other people share the last name, and the second block of code shows you how many people share your first and last name, if it all. 
 
 -- 7.) Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
 SELECT first_name, gender, count(*) FROM employees
 WHERE first_name IN ('Irena', 'Vidya', 'Maya')
 GROUP BY first_name, gender;
 
 
 -- 8.) Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
 
 SELECT
 lower(concat(substr(first_name, 1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS username,
count(concat(substr(first_name, 1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2)))
FROM employees
GROUP BY username
ORDER BY count(username)
DESC;


 SELECT
 lower(concat(substr(first_name, 1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS username,
count(concat(substr(first_name, 1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS count
FROM employees
GROUP BY username
ORDER BY count(username)
DESC;

 SELECT
 lower(concat(substr(first_name, 1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS username,
count(concat(substr(first_name, 1,1), substr(last_name,1,4), '_', substr(birth_date,6,2), substr(birth_date,3,2))) AS count
FROM employees
GROUP BY username
HAVING count >1
ORDER BY count(username)
DESC;



-- There are duplicate usernames, because plenty of usernames have a count higher than 1. 
-- Bonus:  There are 13,251 DUPLICATE usernames. 
