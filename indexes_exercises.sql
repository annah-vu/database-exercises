USE employees;

-- 2.) DESCRIBE each table and inspect the keys and see which columns have indexes and keys.

DESCRIBE departments;
   # Departments has a primary key on dept_no, and a unique key on dept_name. 
DESCRIBE dept_emp;
	# Dept_emp has a primary key on emp_no and dept_no.
DESCRIBE dept_manager;
	# dept_manager has a primary key on emp_no and dept_no
DESCRIBE employees;
	# employees has a primary key on emp_no.
DESCRIBE salaries;
	# salaries has a primary key on emp_no and from_date
DESCRIBE titles;
	# titles has a primary key on emp_no, title, and from_date