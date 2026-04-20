-- rename a column
alter table customers rename city to town;

--drop a column
alter table customers drop column phone;

--reinsert phone column
 alter table customers add column phone int;

-- Truncating a table is dropping the table but keeping the structure

/*next part is DML
 * insert
 * update
 * delect
 */

-- insert is used to add columns
insert into customers(customer_id, customer_name, email, town, phone) 
values
(1, 'Grace', 'gracemimi@fff.com','nairobi',0756342222),
(2, 'John', 'john@frfcxa@vcgs.com','nairobi', 0111232652),
(3, 'Mary', 'nsavah@cagavgcs.com','nairobi',0727177732);


select * from customers;

/*
 * We discover that since phone number here is not taking the 0 at the beginning
 * we will want to change phone to text
 * */
alter table customers 
alter column phone type varchar(15);

--inserting data into books
insert into books (book_id, title, author, price, stock) values 
(122, 'Kifo Kisimani', 'Ken Walibora', 800, 4),
(1334, 'Tumbo Lisiloshiba', 'Mwandishi maarufu', 600, 25),
(2430, 'The river and the source', 'Margaret Ogola', 700,17),
(445, 'The aligator', 'robin hood', 1900,2);

select * from books;


/*Next part id DQL
 * select
 */