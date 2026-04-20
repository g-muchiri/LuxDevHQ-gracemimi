-- creating the schema
create schema nairobi_academy;

--show the current schema I am using
show search_path;

--set my schema to the new schema
set search_path to nairobi_academy;

/*
 * SECTION 1: DDL(CREATE, ALTER)
 * */

--creating students table
create table students (
student_id INT primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
gender varchar(1),
date_of_birth date,
class varchar(100),
city varchar(100)
);

--create table subjects
create table subjects(
subject_id int primary key,
subject_name varchar(100) not null unique,
department varchar(100),
teacher_name varchar(100),
credits int
 );

-- create exam_results table
create table exam_results(
result_id int not null primary key,
student_id int not null,
subject_id int not null,
marks int not null,
exam_date date,
grade varchar(2)
);

-- add column phone number to students table

alter table students add column phone_number int;

--rename credits in results table to credit hours
alter table subjects rename credits to credit_hours;

-- remove phone number from students

alter table students drop column phone_number;

/*
 * SECTION B FILLING THE TABLES DML(INSERT, UPDATE, DELETE)
 * */

-- FILLING THE STUDENTS TABLE
insert into students(student_id,first_name,last_name,gender,date_of_birth,class,city)
values
(1,'Amina','Wanjiku','F','2008-03-12','Form-3','Nairobi' ),
(2,'Brian','Ochieng','M','2007-07-25','Form-4','Mombasa'),
(3, 'Cynthia', 'Mutua','F','2008-11-05','Form3','Kisumu'),
(4,'David','Kamau','M','2007-02-18','Form 4','Nairobi'),
(5,'Esther','Akinyi','F','2009-06-30','Form 2','Nakuru'),
(6,'Felix','Otieno','M','2009-09-14','Form 2','Eldoret'),
(7,'Grace','Mwangi','F','2008-01-22','Form 3','Nairobi'),
(8,'Hassan','Abdi','M','2007-04-09','Form 4','Mombasa'),
(9,'Ivy','Chebet','F','2009-12-01','Form 2','Nakuru'),
(10,'James','Kariuki','M','2008-08-17','Form 3','Nairobi');

--Lesson learnts, values are in '', name of columns are in ''

--FILLING EXAM RESULTS TABLE

insert into exam_results values
(1,1,1,78,'2024-03-15','B'),
(2,1,2,85,'2024-03-16','A'),
(3,2,1,92,'2024-03-15','A'),
(4,2,3,55,'2024-03-17','C'),
(5,3,2,49,'2024-03-16','D'),
(6,3,4,71,'2024-03-18','B'),
(7,4,1,88,'2024-03-15','A'),
(8,4,6,63,'2024-03-19','C'),
(9,5,5,39,'2024-03-20','F'),
(10,6,9,95,'2024-03-21','A');

--insert data into subjects table

insert into subjects values
(1,'Mathematics','Sciences','Mr. Njoroge',4),
(2, 'English', 'Languages','Ms. Adhiambo',3),
(3, 'Biology','Sciences', 'Ms. Otieno',4),
(4, 'History', 'Humanities','Mr. Waweru',3),
(5, 'Kiswahili', 'Languages','Ms. Nduta',3),
(6, 'Physics','Sciences','Mr. kamande',4),
(7, 'Geography', 'Humaniries', 'Ms. Chebet',3),
(8, 'Chemistry','Sciences','Ms. Muthoni',4),
(9, 'Computer Studies', 'Sciences', 'Mr Oduya',3),
(10,'Business Studies', 'Humanities','Ms. Wangari',3);

--change Esthers city to Nairobi
update students
set city = 'Nairobi'
where student_id =5;

select * from students;

--delete exam result 9

delete from exam_results where result_id = 9;

select * from exam_results;


--correct marks for result id 5 are 59 and not 49

update exam_results
set marks =59
where result_id = 5;



/*
 * SECTION 3: QUERRYING THE DATA
 * */

--find all students n form 4
select * from students where class in ('Form 4', 'Form-4');

--all female students
select * from students where gender = 'F';

--in form 3 from nairobi
select * from students where class in ('Form-3','Form 3') and city = 'Nairobi';

--find all exam results where marks are between 50 and 80 inclusive
select * from exam_results;

select * from exam_results where marks between 50 and 80;

--Exams that took place between 15th and 18th March
select * from exam_results where exam_date between '2024-03-15' and '2024-03-18';

--How many exam results have a mark of 70 and above
select count(*) from exam_results where marks>= 70;

--find all subjects whose subject name contains the word studies
select * from subjects where subject_name ilike '%studies%';


/*
 * FINAL SECTION:- CASE WHEN
 * Write a query using CASE WHEN to label each exam result with a grade description:
 * 'Distinction' if marks >= 80
 * 'Merit' if marks >= 60
 * 'Pass' if marks >= 40
 * 'Fail' if marks below 40
 *  Call the new column performance
 * 
 */
select result_id, student_id, subject_id, marks, grade, 
case 
	when marks >= 80 then 'Distinction'
	when marks >=60 then 'Merit'
	when marks >=40 then 'Pass'
	else 'Fail'
	end as performance
from exam_results;

/*
 * 
 * Write a query using CASE WHEN to label each student as
 * •	'Senior' if they are in Form 3 or Form 4
 * •	'Junior' if they are in Form 2 or Form 1
 * Call the new column student_level
 * 
 * Show the student's first name, last name, class, and student_level in your result.
 * 
 * 
 * */
select * from students;

select first_name, last_name, gender,"class",
case
	when class in ('Form 3','Form-3', 'Form 4', 'Form-4' ) then 'Senior'
	when class in ('Form 2','Form-2', 'Form 1', 'Form-1') then 'Junior'
end as student_level
from students;

--Practising update
update students set class = 'Form 3' where student_id = 3;






