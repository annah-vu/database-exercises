-- of current employees, what percentage are managers?
-- thanks ray
SELECT COUNT(dm.emp_no) / COUNT(e.emp_no)
FROM dept_emp AS e
LEFT JOIN dept_manager AS dm
    USING(emp_no)
WHERE e.to_date > curdate();

-- can you make a query that gives me a yes or no if they are still working?
select *, case when to_date > curdate() then 'yes' else 'no' end as 'still_working'
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no;

-- if their salary is low, medium, or high. Low is anything under the 30ks, mid is between 30-70k, and high is over 70k for current employees
select employees.emp_no, salary, 
case when salary < 30000 then 'low'
	when salary between 30000 and 70000 then 'mid'
	else 'high' end as 'salary level'
from employees
join salaries on employees.emp_no = salaries.emp_no
where to_date like '9999%';

--highest salary of departments
select distinct departments.dept_name, max(salary)
from dept_emp
join departments on dept_emp.dept_no = departments.dept_no
join salaries on dept_emp.emp_no = salaries.emp_no
join employees as e on dept_emp.emp_no = e.emp_no
group by dept_name;

-- name of highest paid employee in each department
select T.emp_no, salary, first_name, last_name, dept_name
from (
     select T.emp_no, salary,
            row_number() over(partition by dept_name order by salary desc) as rn   , dept_name    , T.to_date
     from salaries as T
     	join dept_emp on dept_emp.emp_no = T.`emp_no`
     	join departments on departments.dept_no = dept_emp.dept_no
            ) as T
join employees on employees.emp_no = T.emp_no
where rn < 2 and to_date > curdate();

use employees;
-- Top 5 paid employees who had 2 or less pay changes
--I think this is it
with cte as (
select e.emp_no, max(salary), from_date, count(from_date) OVER (partition by emp_no ORDER BY emp_no) as num_change
from employees as e
join salaries on salaries.emp_no = e.emp_no
group by e.emp_no, from_date
order by salary desc)
select * from cte where num_change < 3
limit 5;

-- with all info
with cte as (
select e.emp_no, max(salary), from_date, count(from_date) OVER (partition by emp_no ORDER BY emp_no) as num_change
from employees as e
join salaries on salaries.emp_no = e.emp_no
group by e.emp_no, from_date
order by salary desc)
select * from cte
join employees on cte.emp_no = employees.emp_no
where num_change < 3;


-- What department is the most expensive to upkeep (currently)?
select dept_name, sum(salary)
from salaries
join dept_emp on dept_emp.emp_no = salaries.emp_no
join departments on dept_emp.dept_no = departments.dept_no
where salaries.to_date like '9999%'
group by dept_name
order by sum(salary) desc;


-- max salary for current non managers in each dept?
select dept_name, max(salary) as most_nonmgt
from salaries
join dept_emp on dept_emp.emp_no = salaries.emp_no
join departments on dept_emp.dept_no = departments.dept_no
join dept_manager on dept_manager.emp_no = salaries.emp_no
where salaries.to_date like '9999%' and salaries.emp_no not in (select emp_no from dept_manager
where to_date like '9999%')
group by dept_name
order by most_nonmgt;


-- avg time between orders by customers
SELECT CustID, AVG(OrderDate - PriorDate)
FROM (
  SELECT
    CustID,
    OrderDate,
    LAG(OrderDate) OVER (PARTITION BY CustID ORDER BY OrderDate) as PriorDate
  FROM Orders)
GROUP BY CustID

select datediff(to_date, from_date) from salaries;

select distinct emp_no, avg(datediff(to_date, from_date)) over(partition by emp_no) as 'avg_time' from salaries
where to_date not like '9999%'
group by emp_no, to_date, from_date;