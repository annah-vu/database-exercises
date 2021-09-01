/* SQL Basics */

-- Creating tables
create table EmployeeDemographics
(EmployeeID int, 
FirstName, varchar(50),
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

select JobTitle, AVG(Salary) from EmployeeDemographics
inner join EmployeeSalary on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where JobTitle = 'Salesman'
Group by JobTitle;