set search_path to company;

--Union combines results into one column and removes duplicates

select name from employees
union
select department_name from departments;

--union all sombines results into one column and keeps duplicates


set search_path to evening;

-- intersect returns a columnof only common records

select customer_id from customers
intersect -- returns only common records
select customer_id from orders;

select customer_id from customers
except -- returns records from the first query that are not in the second
select customer_id from orders;

set search_path to company;
--find all employees who are also managers

select * from employees;
-- CROSS JOIN - returns every combination of rows from both tables
select e.name, d.department_name
from employees e
cross join departments d;


--classic examples of self join
select distinct e.name, m.employee_id  from employees e 
inner join employees m on e.employee_id = m.manager_id ;

select distinct e.name as employee_name
from employees e

/*Natural join automatically joins tables using all columns that have the same name
 in this case since department_id is a name  that is both common in employees and in departments
 a natural join on departments will fetch all employees and department id will only appear once apprending 
 each department id with its adjacent description.*/

select * from employees;
select * from departments;

select * from employees natural join departments;

create table employees_batch2(
employee_id int primary key,
name varchar(50) not null,
department_id int,
manager int,
salary int not null
);

select * from departments;

insert into employees_batch2(employee_id, name, department_id, manager, salary) values
(20,'Grace',4,null,100000),
(21,'Mary Joy',1,1,200000),
(22,'Elias',3,1,50000),
(23,'Susan Grace',2,1,120000),
(24,'Sheia',1,null,110000);

select * from employees_batch2;
select * from employees;

select * from employees_batch2 natural join employees;

select * from employees natural join departments d ;
inner join employees m
on e.employee_id=m.manager_id;


/*
 * While joins combines tables horizontally, a union combines them vertically stacking them
 * This feels more like combining different sheets with the same 
 * 
 * */

select * from employees
union all
select * from employees_batch2
order by employee_id;

--select employees and their managers
select * from employees;
update employees set manager_id = 4 where employee_id in(5,1);

select e.name, m.name from employees e inner join employees m
on e.manager_id = m.employee_id;

/*
 * From the above querry it is important to note that the column being pointed to in the 
 * on section is the primay key
 * 
 * */