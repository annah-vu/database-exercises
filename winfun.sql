-- Over
/* signifies a window of rows which the window function is applied. */
select *, sum(salary) over() as total_salary
from dept_emp;

-- Partition By
/* used in conjunction with over, kind of like the group by */
SELECT e.first_name, e.last_name, e.gender, departments.`dept_name`, salaries.salary, AVG(SALARY) OVER(PARTITION BY dept_name) as avg_dept_salary 
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by hire_date
limit 5;

-- Order By
/* to arrange rows within a partition, use order by within the over clause */
SELECT e.first_name, e.last_name, e.gender, departments.`dept_name`, salaries.salary, AVG(SALARY) OVER(PARTITION BY dept_name order by salary desc) as avg_dept_salary 
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by dept_name
limit 20;

-- Row_Number
/* use row_number window function to get a unique sequential number to each row of the table */
select *, row_number() over() as 'row_number'
from employees

/* use row_number with a partition to get ranks within each subject you are partitioning by */
select *, row_number() over(partition by dept_name order by salary) as "partition_row_number"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

-- Rank
/* ranks rows within their partition based off given condition */
select *, row_number() over(partition by dept_name order by salary) as "partition_row_number",
rank() over(partition by dept_name order by salary) as "partition_rank"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

/* if there are salaries that are the same, it won't rank the next one accordingly. 
Use dense_rank instead! */
select *, row_number() over(partition by dept_name order by salary) as "partition_row_number",
rank() over(partition by dept_name order by salary) as "partition_rank",
dense_rank() over(partition by dept_name order by salary) as "partition_dense_rank"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

--Nth value
/* retrieve nth value from a window frame for an expression */
select *, nth_value(first_name, 2) over(partition by dept_name order by salary desc range between unbounded preceding and unbounded following) as "second"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

--Ntile
/* used to determine percentile */
select *, ntile(4) over(partition by dept_name order by salary asc) as "quartile"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();

-- Lead and Lag
/* compare value of current row to that of its preceding or succeeding row.*/
select *, lead(salary,1) over(partition by dept_name order by salary desc) as "sal_next"
from employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
and salaries.to_date>curdate();