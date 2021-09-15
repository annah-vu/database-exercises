-- Over
--------------------------------------------------------------------------------------------
/* signifies a window of rows which the window function is applied.
in this example: we're going to sum all of the salaries and display it in a new column called total_salary */
select *, sum(salary) over() as total_salary
from salaries;

-- and display overall average salary 
select *, avg(salary) over() as total_salary
from salaries

-- and display overall avg current salaries
select *, avg(salary) over() as total_salary
from salaries
where to_date > curdate()
limit 5;

-- Partition By
--------------------------------------------------------------------------------------------
/* used in conjunction with over, kind of like the group by
in this example: we selected emp name, gender, dept_name, salary, and gave the average current salary for each department */
SELECT e.first_name, e.last_name, e.gender, departments.`dept_name`, salaries.salary, AVG(SALARY) OVER(PARTITION BY dept_name) as avg_dept_salary 
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by hire_date
limit 5;

-- concat first and last name
SELECT concat(e.first_name,' ', e.last_name) as employee_name, e.gender, departments.`dept_name`, salaries.salary, AVG(SALARY) OVER(PARTITION BY dept_name) as avg_dept_salary 
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by hire_date
limit 5;

-- multiple partitions
SELECT concat(e.first_name,' ', e.last_name) as employee_name, e.hire_date, e.gender, departments.`dept_name`, salaries.salary, AVG(SALARY) OVER(PARTITION BY dept_name) as avg_dept_salary, 
min(salary) over(partition by dept_name) as min_dept_salary, max(salary) over(partition by dept_name) as max_dept_salary
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by hire_date desc
limit 5;


-- Row_Number
--------------------------------------------------------------------------------------------
/* use row_number window function to get a unique sequential number to each row of the table, alias in quotes if you use row number*/
select *, row_number() over() as 'row_number'
from employees

-- you can assign the row number based off what you order by 
select *, row_number() over(order by emp_no desc) as number 
from employees

/* use row_number with a partition to get row numbers within each subject you are partitioning by, and if you want it based off 
a certain variable, order by it */
select *, row_number() over(partition by dept_name order by salary) as "partition_row_number"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

-- Order By
/* you can use order by if you use rank or row_number, otherwise put it outside of the window */
SELECT e.first_name, e.last_name, e.gender, departments.`dept_name`, salaries.salary, row_number() OVER(PARTITION BY dept_name order by salary desc) as 'rank'
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by 'rank';

-- another example where I don't have to use a quoted alias
SELECT e.first_name, e.last_name, e.gender, departments.`dept_name`, salaries.salary, row_number() OVER(PARTITION BY dept_name order by salary desc) as num
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by num desc;


-- Rank
--------------------------------------------------------------------------------------------
/* ranks rows within their partition based off given condition, alias in quotes 
in the following example, I am getting an assigned row number for people depending on their salary within dept.
I am also ranking them based on their salary within department.
I didn't order it by desc, so the lowest employees are lower numbers */
select *, row_number() over(partition by dept_name order by salary) as "partition_row_number",
rank() over(partition by dept_name order by salary) as "partition_rank"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

/* if there are salaries that are the same, it won't rank the next one accordingly. 
Use dense_rank instead! 
Keep in mind if the alias is in quotes you cant order by it. */
select *, row_number() over(partition by dept_name order by salary) as "partition_row_number",
rank() over(partition by dept_name order by salary) as "partition_rank",
dense_rank() over(partition by dept_name order by salary) as "partition_dense_rank"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

-- renamed so we can order by it
select *, row_number() over(partition by dept_name order by salary) as assigned,
rank() over(partition by dept_name order by salary) as position,
dense_rank() over(partition by dept_name order by salary) as accurate_position
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate()
order by accurate_position desc;

--Nth value
--------------------------------------------------------------------------------------------
/* retrieve nth value from a window frame for an expression */
select *, nth_value(first_name, 2) over(partition by dept_name order by salary desc range between unbounded preceding and unbounded following) as "second"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

--Ntile
--------------------------------------------------------------------------------------------
/* used to determine percentile
the smallest number quartile corresponds to how the info is ordered
ex: in this example, salary goes from low to high, so 1st quartile is the lowest paid, 4th is highest within each partition */
select *, ntile(4) over(partition by dept_name order by salary asc) as "quartile"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

-- no partition here, just quartiles of salaries
select *, ntile(4) over(order by salary) as "quartile"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

-- Lead and Lag
--------------------------------------------------------------------------------------------
/* compare value of current row to that of its preceding or succeeding row.*/
select *, lead(salary,1) over(partition by dept_name order by salary desc) as "sal_next"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();


--average change in salary by employees
with cte as(select emp_no, from_date, lag(salary,1) over(partition by emp_no) as prev_salary, salary as current_salary, salary - LAG(salary,1,0) OVER(ORDER BY emp_no) AS difference from salaries
)
select emp_no, avg(difference) from cte
group by emp_no;

-- this avg will not account for the very first salary
with cte as(select emp_no, from_date, lag(salary,1,salary) over(partition by emp_no) as prev_salary, salary as current_salary, salary - LAG(salary,1,salary) OVER(partition by emp_no ORDER BY emp_no) AS difference, row_number() over(partition by emp_no) as 'number' from salaries)
select emp_no, avg(difference)
from cte
where difference <> 0
group by emp_no;

-- this will also not account for the very first salary
with cte as(select emp_no, from_date, lag(salary,1,salary) over(partition by emp_no) as prev_salary, salary as current_salary, salary - LAG(salary,1,salary) OVER(partition by emp_no ORDER BY emp_no) AS difference, row_number() over(partition by emp_no) as 'number' from salaries)
select emp_no, avg(difference)
from cte
where number > 1
group by emp_no;


-- full outer
SELECT * FROM employees
left join salaries on salaries.emp_no = employees.emp_no
UNION ALL
SELECT * FROM employees
right join salaries on salaries.emp_no = employees.emp_no;


-- -- Show the average sales total and average units sold by transaction by customer
-- replace max with count
select distinct emp_no, avg(salary) over (partition by emp_no) as avg_pay, max(from_date) over (partition by emp_no) as recent
from salaries;



select distinct emp_no, avg(salary) over(partition by emp_no) from salaries;

select distinct emp_no, avg(salary) over(partition by emp_no) as average from salaries
order by average desc;