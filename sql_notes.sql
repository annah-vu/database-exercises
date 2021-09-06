/* SQL Basics */

-- Creating tables
create table EmployeeDemographics
(EmployeeID int, 
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
);

create table EmployeeSalary
(EmployeeID int, 
JobTitle varchar(50),
Salary int);

insert into EmployeeDemographics values
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male');

insert into EmployeeSalary values 
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000);


-- Select + From Statements 
select * from EmployeeDemographics;
select FirstName from EmployeeDemographics;
select top 5 * from EmployeeDemographics;
select distinct(Gender) from EmployeeDemographics;
select count(LastName) from EmployeeDemographics;

select count(LastName) as LastNameCount from EmployeeDemographics;

select * from EmployeeSalary;
select max(salary) from EmployeeSalary;
select avg(salary) from EmployeeSalary;
 -- from database.table


/* Where Statement
=, <> (not equal, as well as !=), <, >, And, Or, Like, Null, Not Null, In
*/

select * from EmployeeDemographics
where FirstName = 'Jim';

select * from EmployeeDemographics
where FirstName in('Jim', 'Michael');

select * from EmployeeDemographics
where age <=32 and Gender='Male';

select * from EmployeeDemographics
where LastName like 'S%';

select * from EmployeeDemographics
where LastName like 'S%ott%';

/* Group By Order By */

select distinct(Gender) from EmployeeDemographics;

select Gender from EmployeeDemographics
group by Gender;

select Gender, count(Gender)
from EmployeeDemographics
group by Gender;

select Gender, Age, count(Gender) from EmployeeDemographics
group by Gender, Age; 

select Gender, count(Gender) as CountGender
from EmployeeDemographics
where Age > 31
group by Gender
order by CountGender;

-- ASC is default, DESC for descending. If you are ordering by non numeric, it sorts by alphabetical order
select Gender, count(Gender) as CountGender
from EmployeeDemographics
where Age > 31
group by Gender
order by Age, Gender DESC;

select Gender, count(Gender) as CountGender
from EmployeeDemographics
where Age > 31
group by Gender
order by Age DESC, Gender DESC;

--you dont have to specify column name, you can do it by column number


/* Inner/Outer Joins

Inner joins show everything that is common between two tables*/

select * from EmployeeDemographics
inner join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

/*Fill outer joins show everything, and if there's nothing associated it'll be null*/
select * from EmployeeDemographics
full outer join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

/* left outer joins, everything from the left table but if it's only in the right table we don't want it*/
-- everything in demographics table, if it doesnt match in the salaries it'll be null */
select * from EmployeeDemographics
left outer join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

-- and right does the opposite

-- if you select specific columns, make sure you tell it what table to extract it from if both tables
-- have that column
select EmployeeSalary.EmployeeID, FirstName, LastName from EmployeeDemographics
left outer join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

-- find the average salary for salesman position
select JobTitle, AVG(Salary) from EmployeeDemographics
inner join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where JobTitle = 'Salesman'
Group by JobTitle;


/* Unions 
Similar to joins, a join combines based off common column.
A union selects all data from both tables
union takes out duplicates,
union all will show duplicates */
Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male');

Table 3 Query:
Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
);

Table 3 Insert:
Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female');


select * from EmployeeDemographics
union
select * from WareHouseEmployeeDemographics;

select * from EmployeeDemographics
union all
select * from WareHouseEmployeeDemographics
order by EmployeeID;

-- unions will only work well with tables with the same structure
-- if you try to union tables with different column structures it won't look usable


/* Case Statement */
select FirstName, LastName, Age,
Case
    when Age > 30 then 'old'
    else 'young'
end
from EmployeeDemographics
where age is not null 
order by Age; 

-- keep in mind it performs the cases in order
select FirstName, LastName, Age,
Case
    when Age > 30 then 'old'
    when age between 27 and 30 then 'young'
    else 'baby'
end
from EmployeeDemographics
where age is not null 
order by Age; 

select FirstName, LastName, JobTitle, Salary,
Case
    when JobTitle = 'Salesman' then Salary + (Salary * .10)
    when JobTitle = 'Accountant' then Salary + (Salary * .05)
    else Salary + (Salary * .03)
end as SalaryAfterRaise
from EmployeeDemographics
inner join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;


/* Having Clause 
because you cannot use aggregate functions in where statements
having goes after the group by*/
select JobTitle, count(JobTitle)
from EmployeeDemographics
join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
group by JobTitle
having count(JobTitle > 1);

/* Updating/Deleting Data */





/* some windows stuff */

select * from employees
join salaries on employees.emp_no = salaries.emp_no;

SELECT *, AVG(SALARY) OVER(PARTITION BY gender) as gender_pay 
FROM employees
join salaries on employees.emp_no = salaries.emp_no
AND to_date > curdate()
order by last_name;

SELECT *, AVG(SALARY) OVER(PARTITION BY gender) as gender_pay 
FROM employees
join salaries on employees.emp_no = salaries.emp_no
AND to_date > curdate()
order by hire_date
limit 5;

SELECT *, AVG(SALARY) OVER(PARTITION BY gender) as gender_pay,
rank() over(order by salary DESC)
FROM employees
join salaries on employees.emp_no = salaries.emp_no
AND to_date > curdate()
order by last_name;

SELECT *, AVG(SALARY) OVER(PARTITION BY dept_name) as avg_dept_salary 
FROM employees
join salaries on employees.emp_no = salaries.emp_no
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by hire_date
limit 5;

SELECT e.first_name, e.last_name, e.gender, departments.`dept_name`, salaries.salary, AVG(SALARY) OVER(PARTITION BY dept_name) as avg_dept_salary 
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by hire_date
limit 5;

SELECT e.first_name, e.last_name, e.gender, departments.`dept_name`, salaries.salary, MAX(SALARY) OVER(PARTITION BY dept_name) as max_dept_salary, min(salary) over (partition by dept_name) as min_dept_salary 
FROM employees as e
join salaries on e.emp_no = salaries.emp_no
join dept_emp on e.emp_no = dept_emp.emp_no
join departments on dept_emp.dept_no = departments.dept_no
AND salaries.to_date > curdate()
order by hire_date
limit 5;


SELECT order_id, order_date, customer_name, city, order_amount
 ,SUM(order_amount) OVER(PARTITION BY city) as grand_total 
FROM [dbo].[Orders];

