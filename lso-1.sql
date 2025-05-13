
create database companyHR;

#DROP DATABASE [IF EXISTS] companyHR; 
# no easy way to rename a database in MySQL.we can 

use  companyHR;

-- Commenting
#Another way of commenting

/** Multiple \
Lines of Commenting  **/ 

/** SQL COMMAND Keywords are generally not case sensitive in SQL.common practice is to
use uppercase for keywords. **/

create table co_employess (
#NDSCD  - format for defining columns when creating table. Name, Data Type, Size, Constraint, Default. 
id int primary key auto_increment,   # IF AUTO_INCREMENT constraint- that column must have unique or primary constraint
/**   FLOAT(m, d)  - uses 4 bytes of storage
 FLOAT(5, 3), it will
be rounded off to 12.346 (i.e. 5 digits in total, three of which are after the
decimal point). **/
# DOUBLE(m, d) - 8 bytes
#DECIMAL(m, d)  used to store monetory data

emp_name VARCHAR (255) NOT NULL, 
gender CHAR(1) NOT NULL,  /** store fixed length string of up to 255 characters.
#IF srtore shorter than the specified length, the string will be
right-padded with spaces. IF CHAR(5) defined and you put text as 
"NY" then it stored as "NY   ". 3 spaces added to match defined character length **/

contact_num  VARCHAR(255), # Variable length of character. won't padded with spaces. 
# Memory save. But slower than CHAR in accessing


age int not null,   
# UNIQUE - constraint can hold null value 
#PRIMARY KEY- unique+NOT NULL - one table can contain only 1 primary key
# AUTO INCREEMENT -starts with 1.  One table can conytain only one column with this
date_created Timestamp not null DEFAULT NOW()
#DATE - stores in YYYY-MM-DD
#TIME  - HH:MI:SS format
# DATETIME - supports date range '1000-01-01 00:00:00' to '9999-12-31 23:59:59'.
                                #(VS)
/** TIMESTAMP- YYYY-MM-DD HH:MI:SS - UTC+4 time zone and stores a TIMESTAMP as 
'2018-04-11 09:00:00', someone in the UTC time zone will see this data as '2018-04-11 05:00:00'. **/

);

CREATE TABLE MENTORSHIPS (
MENTOR_ID INT NOT NULL, 
MENTEE_ID INT NOT NULL, 
STATUS VARCHAR(255) NOT NULL,
PROJECT VARCHAR (255) NOT NULL,

PRIMARY KEY (MENTOR_ID, MENTEE_ID),
CONSTRAINT FK1 FOREIGN KEY(MENTOR_ID) REFERENCES
co_employess (ID) ON DELETE CASCADE ON UPDATE RESTRICT,

CONSTRAINT FK2 FOREIGN KEY (MENTEE_ID) REFERENCES
co_employess (ID) ON DELETE CASCADE ON UPDATE RESTRICT,

CONSTRAINT MM_CONSTRAINT UNIQUE(MENTOR_ID, MENTEE_ID)
) ;

RENAME TABLE co_employess to employees;

# Page Number 45

ALTER TABLE EMPLOYEES MODIFY ID INT ; 
# YOU CAN'T ALTER BECAUSE FROM MENTORSHIPS TABLE THE 'ID' COLUMN REFERRED AS UPDATE RESTRICT


ALTER TABLE EMPLOYEES
  DROP COLUMN AGE,
  ADD COLUMN SALARY FLOAT NOT NULL AFTER CONTACT_NUM,
  ADD COLUMN YEARS_IN_COMPANY FLOAT  NOT NULL AFTER SALARY;
  
  
  DESCRIBE EMPLOYEES; 
  
  
  ALTER TABLE MENTORSHIPS
	DROP CONSTRAINT FK2; 
    
ALTER TABLE MENTORSHIPS
	ADD CONSTRAINT FK2 foreign key MENTORSHIPS (MENTEE_ID) references 
    EMPLOYEES(ID) ON DELETE cascade ON  UPDATE CASCADE;
    
CREATE TABLE DEMO(
ID INT PRIMARY KEY, 
NAME VARCHAR(25) NOT NULL
);



DROP TABLE DEMO;

# page number 49

INSERT INTO employees (emp_name, gender, contact_num, salary,
years_in_company) VALUES
('James Lee', 'M', '516-514-6568', 3500, 11),
('Peter Pasternak', 'M', '845-644-7919', 6010, 10),
('Clara Couto', 'F', '845-641-5236', 3900, 8),
('Walker Welch', 'M', NULL, 2500, 4),
('Li Xiao Ting', 'F', '646-218-7733', 5600, 4),
('Joyce Jones', 'F', '523-172-2191', 8000, 3),
('Jason Cerrone', 'M', '725-441-7172', 7980, 2),
('Prudence Phelps', 'F', '546-312-5112', 11000, 2),
('Larry Zucker', 'M', '817-267-9799', 3500, 1),
('Serena Parker', 'F', '621-211-7342', 12000, 1);



INSERT INTO mentorships VALUES
(1, 2, 'Ongoing', 'SQF Limited'),
(1, 3, 'Past', 'Wayne Fibre'),
(2, 3, 'Ongoing', 'SQF Limited'),
(3, 4, 'Ongoing', 'SQF Limited'),
(6, 5, 'Past', 'Flynn Tech');
select * from employees;
select * from mentorships;

update employees 
set contact_num = '516-514-1729'
where id =1; 


delete  from employees
	where id = 5 ; 
 
 
 #page num 54
insert into mentorships value 
	(4, 21, 'Ongoing', 'Flynn Tech');
/*Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails
-- (`companyhr`.`mentorships`, CONSTRAINT `FK2` FOREIGN KEY (`MENTEE_ID`) 
-- REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE CASCADE) */

update employees 
 SET id =12
 where id =1;  
/*Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`companyhr`.`mentorships`, 
CONSTRAINT `FK1` FOREIGN KEY (`MENTOR_ID`) REFERENCES `employees` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT)
*/
update employees 
	set id = 11
    where id =4; 
                      
                      #Chapter 5. Selecting the Data Part (Page Num : 59)
                     #======================================================
/* SELECT column_names_or_other_information
[AS alias]
[ORDER BY column(s)] [DESC]
FROM table_name
[WHERE condition]; */
 
 
 select * from employees; 
 
		#filtering columns
 select emp_name, gender from employees; 
 
 #Using alias 
 select emp_name as "Employee Name", gender as "Gender" from employees; 
 
    #Filtering Rows
select * from employees limit 3; 

select DISTINCT (gender ) from employees ; 

   #where clause 
update employees
   set contact_num = "7787-74774-33"
   where id = 2; 
   
   
       # Comparision 
select * from employees where id !=1;

# Between 
select * from employees where id between 1 and 5; 

	# Like (Regular expressions )
select * from employees  where emp_name  Like '%er'; 

select * from employees where emp_name Like '%er%';

    # 5th charcter is 'e'. So 4 under infens. After the 5 th character we may have as many 
    #character we have. 
select * from employees where emp_name Like '____e%';

#    in 
select * from employees where id in (3,6,7 );

# not in 

select * from employees where id not in (3,6,7);

select * from employees where (years_in_company >5 or salary >5000) 
	and gender = 'F';


                           # Subqueries (page Num : 67)
                           
/*Subqueries are commonly used to filter the results of one table based on the
results of a query on another table.*/

select * from employees where id  in (
	select mentee_id from mentorships where project ="SQF Limited" );
    
                      # Sorting Rows
Select * from employees order by gender, id ; 

select * from employees order by gender desc, emp_name; 

               #Selecting the Data Part 2 
               
#A function is a block of code that does a certain job for us.
# Dont give space between function key word and bracket (). there is change in color for function key words. 
 
select CONCAT('hello ', 'world'  );

select SUBSTRING('programming', 2);

#from 2 nd character to 5 th character. output : rogram
select substring ('programming', 2, 5);

select CONCAT('current date and time is :', NOW());

select concat('current date :', CURDATE());

select CONCAT('curret time :', CURTIME());

				# Aggreagate Functions 
select count(*) from employees ; 
#it returns the total number of rows in the table.

select count(gender) from employees; 
#it returns the number of non NULL values

select count(distinct gender) from employees; 
# to get distinct values, we add the DISTINCT keyword before the column name.

select avg(salary) from employees; # avg salary of all the employees 

select round(avg(salary), 3) from employees; # Round with 3 decimal places

select max(salary) from employees; 

select min(salary) from employees; 

select sum(salary) from employees; 

					# GROUP BY 
                    
# group the data before performing calculations. 

select gender , sum(salary) from employees group by gender; 

select gender , max(salary) from employees group by gender; 

							# Having 
/*In addition to performing calculations on grouped data, we can also filter the
results of the grouped data. We do that using the HAVING clause.
*/


select gender , max(salary) from employees group by gender 
	having max(salary)> 10000;

							#JOINS
/*
SELECT [table_names.]columns_names_or_other_information
FROM
left_table
JOIN / INNER JOIN / LEFT JOIN / RIGHT JOIN
right_table
ON
left_table.column_name = right_table.column_name;
*/

CREATE DATABASE BookStore;

USE BookStore;

CREATE TABLE Books
(
Id INT  PRIMARY KEY AUTO_INCREMENT,
Book_Name VARCHAR (50) NOT NULL,
Price INT,
CategoryId INT, 
AuthorId INT
);


CREATE TABLE Categories (
Id INT PRIMARY KEY,
Cat_Name VARCHAR (50) NOT NULL
);
 

CREATE TABLE Authors
(
Id INT PRIMARY KEY,
Auth_Name VARCHAR (50) NOT NULL
);


INSERT INTO Categories VALUES (1, 'Cat-A'),
(2, 'Cat-B'),
(3, 'Cat-C'),
(7, 'Cat-D'),
(8, 'Cat-E'),
(4, 'Cat-F'),
(10,'Cat-G'),
(12,'Cat-H'),
(6, 'Cat-I');


INSERT INTO Authors
VALUES (1, 'Author-A'),
(2, 'Author-B'),
(3, 'Author-C'),
(10, 'Author-D'),
(12, 'Author-E');

INSERT INTO Books (Book_Name, Price, CategoryID, AuthorId)
VALUES ( 'Book-A', 100, 1, 2),
( 'Book-B', 200, 2, 2),
( 'Book-C', 150, 3, 2),
( 'Book-D', 100, 3,1),
( 'Book-E', 200, 3,1),
( 'Book-F', 150, 4,1),
( 'Book-G', 100, 5,5),
( 'Book-H', 200, 5,6),
('Book-I', 150, 7,8);

            #Inner Join
SELECT books.categoryID, Books.Book_Name, categories.ID, categories.Cat_Name
	from books inner join 
    categories 
    on books.categoryID= categories.ID;
             # Left Join 
SELECT books.categoryID, Books.Book_Name, categories.ID, categories.Cat_Name
	from books left join 
    categories 
    on books.categoryID= categories.ID;
    
					#Right Join 
SELECT books.categoryID, Books.Book_Name, categories.ID, categories.Cat_Name
	from books right join 
    categories 
    on books.categoryID= categories.ID;
    
# Full outer Join is not available in MYSQL. it's available in MS SQL Server. 
#we can bring full join in the below way. 

SELECT books.categoryID, Books.Book_Name, categories.ID, categories.Cat_Name
	from books left join 
    categories 
    on books.categoryID= categories.ID
    union
    SELECT books.categoryID, Books.Book_Name, categories.ID, categories.Cat_Name
	from books right join 
    categories 
    on books.categoryID= categories.ID;
    
                                     # Unions 
/*
The UNION keyword is used to combine the results of two or more SELECT
statements. Each SELECT statement must have the same number of columns.

The syntax is:
SELECT_statement_one
UNION
SELECT_statement_two;
*/

use companyhr; 
SELECT emp_name, salary FROM employees WHERE gender = 'M'
UNION
SELECT emp_name, years_in_company FROM employees WHERE gender = 'F';


							# SQL View 
# SQL view is a virtual table.
/* views do not contain data. Instead, they contain
SELECT statements. The data to display is retrieved using those SELECT
statements. */

/* we can create a view with few specific columns from one table
 and we can give access to that view for developers. 
 So that developers have restricted access to all the columns on the table.
 They only have access to sepcific columns whcih are all part of the view.
 */
     
           #Creating View 
/* CREATE VIEW name_of_view AS
SELECT statement;
*/



 
create view myview as 
SELECT employees.id, mentorships.mentor_id, employees.emp_name AS
'Mentor', mentorships.project AS 'Project Name'
from mentorships 
join 
employees on mentorships.mentor_id = employees.id; 


/* This view holds Mentors name and their project information. Which is not present in single table.
 we are getting in single view by joining multiple tables.
 */
select * from myview ; 

select mentor_id, `Project Name` from myview; 
#  must use the backtick (`) character for mentioning the view's column name
#  which is alias 

				# Altering a view 
                
/*ALTER VIEW name_of_view AS
SELECT statement; */

Alter view myview as 
		select employees.id, mentorships.mentor_id, employees.emp_name AS
'Mentor', mentorships.project as 'Name_of_Project' 
from  mentorships 
join 
employees 
where employees.id = mentorships.mentor_id;

select * from myview; 

drop view if exists myview; 

						# Triggers
/*A trigger is a series of actions that is activated when a defined event occurs
for a specific table. This event can either be an INSERT, UPDATE or DELETE.
Triggers can be invoked before or after the event. */

/*
one of the employees has just resigned from the company and we
want to delete this employee from the employees table
*/
                        
                       
create table ex_employees (
emp_id int primary key, 
emp_name varchar(25), 
gender character (1),
date_left timestamp default NOW()

);    
                    
delimiter $$
create trigger update_ex_emps before delete on employees 
for each row 
BEGIN
   insert into ex_employees (emp_id, emp_name, gender) values (old.id,old.emp_name, old.gender);
 END $$

delimiter ; 

delete from employees where id = 10 ; 

SELECT * FROM employees;
SELECT * FROM ex_employees;

#deleting the trigger 
drop trigger update_ex_emps;

								#Variables 

/*A variable is a name given to data that we need to store and use in our SQL
statements. */
use companyhr;

#we want to see empployee with id = 1 data from all the tables
SELECT * FROM employees WHERE id = 1;
SELECT * FROM mentorships WHERE mentor_id =  1;
SELECT * FROM mentorships WHERE mentee_id =  2;

# now we need to see for employee with id =6. 
#we no need to write manually change value in all places.

# Declaring and Initialising variable 
set @emp_id = 6; 

SELECT * FROM employees WHERE id = @emp_id;
SELECT * FROM mentorships WHERE mentor_id =  @emp_id;
SELECT * FROM mentorships WHERE mentee_id =  @emp_id;

#set @emp_id =7.   We can always change the value of the variable later.
SET @em_name = 'Jamie'; # we can assign string
 
 SET @price = 12;
SET @price = @price + 3; # we can assign a resulr of mathematical operation
#SET statements always work from right to left (i.e. the right side of the
#statement is executed first). In other words, 3 is added to the original value of @price first.

#we can assign the result of a function to a variable

set @result = SQRT(9);
select @result ; 
select @result := SQRT (25); #  Assigning and displaying in same line. 
#have to use the := symbol to do the assignment in the SELECT statement

                       #Stored Routines 
/* A stored routine is a set of SQL statements that are grouped, named and
stored together in the server.*/ 
 #2 Types of Stored Routines  
            # 1. Stored Procedures and 2. Stored Functions   

#Syntax for Stored Procedures

/* DELIMITER $$ 
create procedure procedure_name ([Parameters, if have any])
BEGIN 
-- SQL statements 
END  $$
DELIMITER ;
*/
# Example :

DELIMITER $$
 create procedure select_info()
 BEGIN 
 select * from employees;
 select * from mentorships;
 END $$
 DELIMITER ;

call select_info(); # calling the procedure 


