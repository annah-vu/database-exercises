-- 1 Create SQL script named limit_exercises.sql

use employees;
# 2.) First 10 distinct last names in descending order
select distinct last_name from `employees`
order by last_name desc
limit 10;

/* 2.) The 10 last distinct names in descending order
Zykh
Zyda
Zwicker
Zweizig
Zumaque
Zultner
Zucker
Zuberek
Zschoche
Zongker

*/

# 3.) Find all previous or current employees hired in the 90s and born on Christmas. Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. Write a comment in your code that lists the five names of the employees returned.

select * from `employees`
where hire_date like '199%'
and birth_date like '%12-25'
order by hire_date
limit 5;

/* 3.) The first 5 records of the first 5 employees hired in the 90s and born on Christmas day is 
	1- Alselm Cappello
	2- Utz Mandell
	3- Bouchung Schreiter
	4-Baocai Kushner
	5- Petter Stroustrup
*/
# 4.) Try to think of your results as batches, sets, or pages. The first five results are your first page. The five after that would be your second page, etc. Update the query to find the tenth page of results. LIMIT and OFFSET can be used to create multiple pages of data. What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), and the page number?

select * from `employees`
where hire_date like '199%'
and birth_date like '%12-25'
order by hire_date
limit 5 offset 45;

/* 4.) the tenth page of results will have 

emp_no	birth_date	first_name	last_name	gender	hire_date
463558	1963-12-25	Pranay	Narwekar	F	1990-07-18
444269	1963-12-25	Marjo	Farrow	F	1990-07-18
291662	1962-12-25	Ennio	Karcich	M	1990-08-05
413687	1954-12-25	Dines	Lubachevsky	F	1990-08-06
416525	1952-12-25	Ipke	Fontan	M	1990-08-06
*/ 

-- We can view offset and limit as pages in a book. Offset tells us which page to go to by defining which entry we want to start off on. For example, if you were reading a book, you don't neccessarily have to start at the title page every single time you open it. You can skip to the page with the content you want to read. Limit tells us how much content we want on each page. We will use limits so that it doesn't take too long to run, similar to how you don't want each page of a book to have an excessive amount of text. Offset cannot be used without limit, because you have to know the parameters of each page befoe you can pick a specific one. 


	