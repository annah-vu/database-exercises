/*to concatenate, you can use the operator ||. In the following example: it will concatenate the employee's first name, a space, and their 
last name as one unnamed column, then it will also pull their email*/

select first_name || ' ' || last_name, email
from customer;

/* alias or renaming like usual. You can select a column and use AS or omit it. */
select column_name as alias_name
from table_name;

select column_name alias_name
from table_name;

select expression as alias_name
from table_name;

select first_name || ' ' || last_name full_name, email
from customer;

/* if the alias contains a space, you'll need to utilize double quotes*/

select first_name || ' ' || last_name "full name", email
from customer;

/* LENGTH() function takes in a string and returns the length.
the following will return the first names of the employees and another column called 'len' which will contain the number 
of characters in everybody's names! (Starting with the longest names to shortest)*/
select first_name, 
LENGTH(first_name) len
from customer
order by len DESC;

/* Nulls first or nulls last? If there are nulls in the column you're ordering by, you can state where they go. NULLS LAST is the default.
So to place null values before other non-nulls, use  NULLS FIRST
 */
SELECT num
FROM sort_demo
ORDER BY num NULLS FIRST;

/* DISTINCT ON () keeps the first row of each group of duplicates, with order by */
select distinct on (column1) 
from table_name
order by column1, column2


/*
Operator	
=	Equal
>	Greater than
<	Less than
>=	Greater than or equal
<=	Less than or equal
<> or !=	Not equal
AND	Logical operator AND
OR	Logical operator OR
IN	Return true if a value matches any value in a list
BETWEEN	Return true if a value is between a range of values
LIKE	Return true if a value matches a pattern
IS NULL	Return true if a value is NULL
NOT	Negate the result of other operators
*/
SELECT
	first_name,
	LENGTH(first_name) name_length
FROM
	customer
WHERE 
	first_name LIKE 'A%' AND
	LENGTH(first_name) BETWEEN 3 AND 5
ORDER BY
	name_length;

/*limits and offsets */
SELECT select_list
FROM table_name
LIMIT row_count OFFSET row_to_skip;

/* Fetch */
OFFSET start { ROW | ROWS }
FETCH { FIRST | NEXT } [ row_count ] { ROW | ROWS } ONLY

/* 
Percent sign ( %) matches any sequence of zero or more characters.
Underscore sign ( _)  matches any single character.
*/

/* LIKE vs. ILIKE
ILIKE is not case sensitive */

/* IS NULL and IS NOT NULL */
SELECT
    id,
    first_name,
    last_name,
    email,
    phone
FROM
    contacts
WHERE
    phone IS NULL;