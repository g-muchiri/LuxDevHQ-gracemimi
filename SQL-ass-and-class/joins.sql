--The command that ensures we are using the intended Schema
set search_path to company;

CREATE TABLE employees
(employee_id SERIAL PRIMARY KEY, 
name VARCHAR (100) NOT NULL, 
department_id INT, 
manager_id INT,
salary NUMERIC (8, 2)
) ;
INSERT INTO employees (name, department_id, manager_id, salary) 
VALUES 
('Alice', 1, NULL, 50000),
('Bob',2, 1, 45000),
('Charlie', 1, 1, 47000), 
('Diana', 3, NULL, 60000),
('Eve',NULL, NULL, 40000);
select * from employees;
 
CREATE TABLE departments 
( department_id INT PRIMARY KEY,
department_name VARCHAR (100));

INSERT INTO departments (department_id, department_name) 
VALUES 
(1, 'Engineering'),
(2,'Sales'),
(3,'Marketing'),
(4, 'Finance');

select * from departments;

CREATE TABLE projects 
( project_id SERIAL PRIMARY KEY, 
project_name VARCHAR (100),
 employee_id INT
) ;


INSERT INTO projects (project_name, employee_id) 
VALUES 
('Redesign Website', 1),
('Customer Survey',2),
('Market Analysis',NULL),
('Mobile App Dev', 3),
('Budget Planning', NULL);

select * from projects;

/*
 * JOINS
 * Inner Join - records that match both tables(It skipps the nulls0
 * Left Join
 * Right Join
 * Full outer Join
 * Self Join
 * Cross join
 * */	

/*
 * INNER JOIN
 * selects rows that match in both tables
 * There is no sequence in tables
 * */

-- employees and their departments
select e.name, d.department_name me 
from employees e inner join 
departments d on e.department_id = d.department_id;

--employees and the projects they are assigned to

select e.name, p.project_name from employees e
inner join projects p on e.employee_id = p.employee_id;
-- As you can see, the nulls are left out

/*
 * THE LEFT JOIN
 *  
 * It returns all rows from the first/left table and any matching rows from the second/right table
 * 
 * */
select e.name, p.project_name from employees e
left join projects p on e.employee_id = p.employee_id;

select e.name, d.department_name me 
from employees e left join 
departments d on e.department_id = d.department_id;


--prectising update
update employees set department_id = NULL where employee_id = 5;

--practising delete rows
delete from employees where employee_id in (6,7,8,9,10);

select * from projects;

/*
 * RIGHT JOIN
 * 
 * returns all rows from the second/right table and only the matching from the first/right table
 * 
 * */
;
--get projects with or without employees
select e.name, p.project_name  from
employees e right join projects p on
e.employee_id = p.employee_id ;


/*
 * FULL OUTER JOIN
 * 
 * It returns all rows from all tables
 * 
 * It is a combination of left join and right join
 * 
 * It is important to note that join means 
 * 
 * */

select * from manager;