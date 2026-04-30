/*
 * Today we will be learning about window functions
 * First category of window function is ranking window function
 * 1. ROW_NUMBER -> The function adds a column which
 * 					assigns a unique number to each row based on a specified order
 * 2. RANK()
 * 3. DENSE_RANK()
 * 4. NTILE(x)-> divides your data into x groups according to the order by criteria
 * 
 * The second category of windo functions is the value window function
 * 
 *1. LAG()->  Access data from a previous row
 *2. LEAD()-> Access data in the next row
 *3. FIRST_VALUE()->Returns value from the first row
 *4. LAST_VALUE()-> Returns value from the last row
 *5. NTH_VALUE()-> returns value from a specific row eg the nth position
 *
 *The third and final category is the aggregate window function
 *These are your standard math functions but instead of collapsing the rows into a
	single total like a group by They keep the rows and add total to each one
	
 *1. SUM()->Great for running totals
 *2. AVG()-> Great for moving averages
 *3. MIN(), MAX()-> Find lowest or highest value within a category
 *4. COUNT()-> Counts items within the window
 * 
 * */
select * from employees;
-- lets rank based on salary
--For row_number, the order by has to be there
--Partition is optional
select *, row_number()over(order by salary desc) as Sal_rank from employees;

set search_path to evening;
select * from books;
select* from orders;
select * from customers;

with new_ob as(
select * from orders natural join books)
select title, quantity, row_number()over(order by quantity desc) as Quantity_rank from new_ob;

/*
 * A thing to note about row number is this, it will give a unique number to each row
 * whether or not there are ties
 * 
 * a book could easily be ranked as number 5, as in this case, yet the quantity is the same
 * as that of rank number 2
 * 
 * 
 * when you partition by say for example customer id, you are essentially telling the program that
 * for every new customer id reset the ranks as seen below
 * */

select customer_id, order_id, quantity, row_number()over(partition by customer_id order by quantity)
from orders;

/*
 * Other window functions include
 * 
 * rank()- rank function assigns a rank to each row with gaps in ranking if there are ties
 * dense_rank()- this function assigns a rank t each row but does not gap whether there 
 * 					are ties or not
 * 
 * */


with new_ob as(
select * from orders natural join books)
select title, quantity, rank()over(order by quantity desc) as Quantity_rank from new_ob;
-- note that the ranks skip from 2 to 6 since there are 4 ties for rank 2

with new_ob as(
select * from orders natural join books)
select title, quantity, dense_rank()over(order by quantity desc) as Quantity_rank from new_ob;
-- note that there are three ranks only despite 10 datapoints since there are 4 ties at 2 and 6 ties at 3

set search_path to company;

select * from employees
union
select * from employees_batch2;

--rank employees according to their salary
with all_emp as(
select * from employees
union
select * from employees_batch2)
select *, rank()over(partition by department_id order by salary desc)as Salo_rank from all_emp;


with all_emp as(
select * from employees
union
select * from employees_batch2)
select *, ntile(4)over(order by salary) as groups from all_emp;


