-- CREATING A DATABASE PT 1
/* if not exists is optional, but good practice */
create database [if not exists] Sales;
-- or
create schema if not exists Sales;

/* string data types:
char = fixed storage
varchar = variable storage

char(5) assigns that a char can have the max of five characters, the reason people use char is because it is
faster 

enum('M','F') will show an error if input is not M or F*/

/* fixed and floating data types

number = 10.523
precision = 5
scale = 3
decimal(5,3)

decimal(7) = decimal(7,0)
decimal = numeric 

floating data types are float and double */

/* other data types

date 
datetime
timestamp
blob (ooh pictures)
*/

-- CREATING A TABLE
/* you need at least one column 
CREATE TABLE table_name(
    column_1 data_type constraints,
    column_2 data_type constraints) */

create table Sales(
    purchase_number int not null primary key auto_increment,
    date_of_purcahse date not null,
    customer_id int,
    item_code varchar(10) not null
);

create table customers(
    customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int
);

select * from sales;
select * from sales.sales;

/* drop table sales;    will delete table*/
create table Sales(
    purchase_number int auto_increment,
    date_of_purcahse date,
    customer_id int,
    item_code varchar(10),
    primary key(purchase_number));

drop table customers;

create table customers(
    customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    number_of_complaints int,
    primary key(customer_id)
)

CREATE TABLE items                                                                                                                              
(  
    item_code varchar(255),   
    item varchar(255),   
    unit_price numeric(10,2),   
    company_id varchar(255),
primary key (item_code)   

);  

    CREATE TABLE companies   
(
    company_id varchar(255),   
    company_name varchar(255),  
    headquarters_phone_number int(12),   
primary key (company_id)   
);

-- Foreign Keys
-- you can create a table with foreign key
drop table sales; 
create table Sales(
    purchase_number int auto_increment,
    date_of_purcahse date,
    customer_id int,
    item_code varchar(10),
    primary key(purchase_number),
    foreign key(customer_id) references customers(customer_id) on delete cascade);

    /* or
    alter the table and add the foreign key
     */
alter table sales
add foreign key(customer_id) references customers(customer_id) on delete cascade;