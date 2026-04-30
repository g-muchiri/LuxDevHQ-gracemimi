set search_path to evening;
--row_number()
--has no duplicates does not recognise tying

--Question 1: Assign a row number to all orders based on order date
select * from orders;

select 
	*,
	row_number()over(order by order_date) as row_num
from orders;

--Question 2: Assign row numbers to orders for each customer separately
select 
	*,
	row_number()over( partition by customer_id order by order_date) as row_num
from orders;

--Question 3: Retrieve the first order made by each customer
select * from(
				select 
					*,
					row_number()over( partition by customer_id order by order_date asc) as row_num
				from orders 
			) 
where row_num = 1;

--Question 4: Retrieve the most recent order for each customer.
--having them organised in descending format will have the latest order coming up to the top

select * from(
				select 
					*,
					row_number()over( partition by customer_id order by order_date desc) as row_num
				from orders 
			) 
where row_num = 1;

--Question 6: Assign a global sequence number to all orders and identify the first 5 orders in the 
--system.
select * from(select 
					order_id, 
					customer_id, 
					row_number()over(order by order_date) as row_num
				from orders)
where row_num <= 5;

--Question 7: Assign row numbers per customer and include customer names.
select * from customers;
select 
	c.customer_id, 
	c.first_name, 
	c.last_name, 
	o.order_id, 
	o.order_date, 
	row_number()over(partition by c.customer_id order by o.order_date) as rom_num
from customers c inner join orders o
on c.customer_id = o.customer_id;

--Question 8: Find customers who have placed more than one order and show their order 
--sequence.

--This querry here shows repeat orders
select * from (select 
					c.customer_id, 
					c.first_name, 
					c.last_name, 
					o.order_id, 
					o.order_date, 
					row_number()over(partition by c.customer_id order by o.order_date) as row_num
				from customers c inner join orders o
				on c.customer_id = o.customer_id) 
		where row_num >1;

--Question 9: Assign row numbers based on quantity instead of date
select 
	*, 
	row_number()over(partition by customer_id order by quantity desc) 
from orders;

--Question 10: For each customer, identify their highest quantity order
select * from(select 
					*, 
					row_number()over(partition by customer_id order by quantity desc) as rno
				from orders
				)
		where rno = 1;

--RANK
-- has duplicates where there are ties but skips the next numbers in the sequence

--Question  1: Rank all employees by salary 
set search_path to company;

--lets combine the two sets of employees into one table
--create table employes_main as (select * from employees union select * from employees_batch2);

--rename it to employees_table
--alter table employes_main rename to employees_table;

select 
	*, 
	rank()over(order by salary desc) as salary_rank 
from employees_table;

set search_path to evening;
-- question 2: Rank customers by total quantity of books ordered
select
	c.customer_id,
	c.first_name,
	c.last_name,
	o.quantity,
	rank()over(order by sum(o.quantity) desc)
from customers c inner join orders o 
on c.customer_id = o.customer_id
group by c.customer_id, c.first_name, c.last_name, o.quantity;

-- an aggregate function in a window function makes the querry behave like that with an aggregate function
-- in a normal query where you need to put group by

--Question 3: Rank employees within each department
set search_path to company;

select 
		name,  
		department_name,
		salary, 
		rank()over(partition by department_id order by salary desc)
from employees_table natural join departments;

--Question 4 Find the second highest earning employee using RANK()
select * from(
				select 
						name,  
						department_name,
						salary, 
						rank()over(order by salary desc)salo_rank
				from employees_table natural join departments)
		where salo_rank = 2;

--Question 5: Rank customers by total revenue generated
set search_path to evening;

select 
	c.first_name, 
	c.last_name, 
	sum(b.price*o.quantity)::numeric as Revenue, 
	rank()over(order by sum(b.price*o.quantity)::numeric desc) as rev_rank
from orders o inner join customers c  on o.customer_id  = c.customer_id 
inner join books b on b.book_id = o.book_id
group by c.first_name, 	c.last_name;

--Dense Rank
--like rank, it assigns a position on each row based on a specific order
-- difference is that there are no gaps if 2 rows share rank 1 then the naext rank will be 2 and not 3 like
--in rank's case

--Question 1:Dense rank all employees by salary 

set search_path to company;

select 
	*, 
	dense_rank()over(order by salary desc) as salary_rank
from employees_table;


--Question 2:- Dense rank customers by total quantity ordered 
set search_path to evening;

select
	c.first_name,
	c.last_name,
	o.quantity,
	dense_rank()over(order by sum(o.quantity) desc) as quantity_purchased
from customers c inner join orders o 
on c.customer_id = o.customer_id 
group by c.first_name, o.quantity,	c.last_name;

--Question 3: Dense rank employees within each department
set search_path to company;
select *, dense_rank()over(partition by department_id order by salary desc) as salo_rank from employees_table;
	
--Question 4: Find the highest paid employee in each department
select * from (select 
					*, 
					dense_rank()over(partition by department_id order by salary desc) as salo_rank
				from employees_table)
		where salo_rank=1;

SELECT  
c.first_name, 
c.last_name, 
c.city, 
SUM(o.quantity) AS total_books, 
SUM(o.quantity * b.price) AS total_revenue, 
DENSE_RANK() OVER (ORDER BY SUM(o.quantity * b.price) DESC) AS 
revenue_rank, 
CASE 
WHEN DENSE_RANK() OVER (ORDER BY SUM(o.quantity * b.price) DESC) = 1 
THEN 'Top Customer' 
WHEN DENSE_RANK() OVER (ORDER BY SUM(o.quantity * b.price) DESC) <= 3 
THEN 'High Performer' 
ELSE 'Regular Customer' 
END AS performance_group 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
JOIN books b ON o.book_id = b.book_id 
GROUP BY c.first_name, c.last_name, c.city 
ORDER BY total_revenue DESC;

/*
 * Lead and lag functions
 * The LEAD() and LAG() functions are used to compare values across rows without using joins.
 * 
 * 1. lag() - looks at the previous row
 * 2. Lead() - looks at the next row
 * 
 * They are commontly use for 
 * 1. Trend analysis
 * 2. Growth/ decline detection
 * 3. Time based comparisons
 * 
 * */
-- lag Example 1
--Show previous quantity 
select order_id , quantity, lag(quantity)over(order by order_id)as prev_quantity from orders;

-- add the difference column
select 
	order_id , 
	quantity, 
	lag(quantity)over(order by order_id)as prev_quantity, 
	(quantity -lag(quantity)over(order by order_id))::numeric as Diff from orders;

-- Per customer comparison
select 
	c.first_name,
	c.last_name,
	o.order_id,
	o.quantity,
	lag(quantity)over(partition by c.customer_id order by order_id)order_lag,
	o.quantity -lag(quantity)over(partition by c.customer_id order by order_id) as order_diff
from customers c inner join orders o 
on c.customer_id = o.customer_id ;

--detecting decrease in orders
select * from(select 
	c.first_name,
	c.last_name,
	o.order_id,
	o.quantity,
	lag(quantity)over(partition by c.customer_id order by order_id)order_lag,
	o.quantity -lag(quantity)over(partition by c.customer_id order by order_id) as order_diff
from customers c inner join orders o 
on c.customer_id = o.customer_id) where order_diff<1;

-- Revenue difference per customer
select
	c.customer_id, 
	c.first_name,
	c.last_name,
	sum(o.quantity * b.price):: numeric as Revenue,
	--o.order_id,
	lag(sum(o.quantity * b.price):: numeric)over(partition by c.customer_id order by o.order_id ) as prev_rev,
	(sum(o.quantity * b.price)
	- 
	lag(sum(o.quantity * b.price):: numeric)over(partition by c.customer_id order by o.order_id )) as rev_diff
	from orders o  inner join customers c
	on c.customer_id = o.customer_id 
	inner join books b  on o.book_id  = b.book_id 
	group by c.first_name, c.last_name,o.order_id,c.customer_id;

 --revenue growth analysis with lead
SELECT  
c.first_name, 
o.order_id, 
(o.quantity * b.price) AS revenue, 
LEAD(o.quantity * b.price) OVER (PARTITION BY o.customer_id ORDER BY 
o.order_id) AS next_revenue, 
LEAD(o.quantity * b.price) OVER (PARTITION BY o.customer_id ORDER BY 
o.order_id) - (o.quantity * b.price) AS revenue_growth 
FROM orders o 
JOIN customers c ON o.customer_id = c.customer_id 
JOIN books b ON o.book_id = b.book_id; 

--10 practice quesions after learning what is expected of you






select * from customers;
select * from orders;
select * from books;