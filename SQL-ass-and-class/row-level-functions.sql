--set my schema to the new schema
set search_path to nairobi_academy;

/*
 * Today we will be learning about low level functions
 * They run on each row at a time unlike aggregate functions
 * 
 * Part 1 - String functions
 * 
 * -upper(text)
 * -lower (text)
 * -length(text)
 * -substring(column, starting from letter index ?, n= number of strings to count)
 * -concatenate(text, text)
 * -trim(text)
 * -replace(text, old_value, new_value)
 * 
 * Part 2 - Number Functions
 * 
 * 
 * Part 3 - Date and time functions
 * 
 * */

---upper(text) and lower(text)
select lower(first_name) as lower_first_name, upper(last_name) as upper_last_name, gender from students;

--length(its used to count characters in a text value)
select subject_name, length(subject_name) as len_subj_name from subjects order by len_subj_name  desc;

--substring
--get me the first three letters of the student's first name
-- we have two approaches, one using substring and the other using left
select first_name, left(first_name,3), substring(first_name, 1,3) from students;

-- in this case you can see that both have given the same result
--you can also as the alias "as" to rename the column

--concat- it is used to join text values together
--in this case let us create a new columns name known as full name

select concat(first_name,' ', last_name) as full_name, gender, class, city from students;

--replace
select * from subjects;

select subject_name, replace(department, 'Sciences','Sci') from subjects;

--trim is just like excel

/*
 * PART TWO
 * NUMBER FUNCTIONS
 * 
 * -round(),ceil(), floor()
 * The functions above all round stuff off
 * round rounds to a specified number of decimals
 * ceil round us while floor rounds down
 * 
 * -abs()- converts negative numbers to positive number
 * 
 * Aggregate functions
 * -avg()
 * -min()
 * -max()
 * -count()
 * */

select 26.9876 as our_number, round(26.9876,2) as rounded_to_two,
ceil(26.9876) as ceiling, floor(26.9876) as floored;





