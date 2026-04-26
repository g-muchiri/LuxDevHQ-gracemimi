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

--aggregate functions
select student_id, count(*) as number_of_exams, avg(marks) as avg_marks
from exam_results
group by student_id
having count(*) > 1;

select*from subjects;

select count(*) from subjects where department = 'Sciences';


/*
 * Date and time functions
 * - YEAR()
 * - MONTH()
 * - DAY()
 * - DATEDIFF()
 * - DATE_TRUNC('year', date '2026/04/21')
 * - INTERVAL()
 * - CURRENT_DATE() gives you a timestamp of the current date
 * - DATEADD(month, number of months to add, 'date')
 * - TO_CHAR() converts into human friendly format	
 * */
--using extract
select first_name, last_name, extract(year from age(now(), date_of_birth))as age_of_student from students;

-- using date_trunc
select first_name, last_name, date_trunc('year', age(now(), date_of_birth))as age_of_student from students;
--date trunc gives you theprefix 18years or 12months etc

--the two functions above serve the same function. Getting the years of the student

--the most important thing to know is this, if you are writting your date as a string, 
-- you will need to put it into single quote and cast it into a date in order to use time functions

--casting into a date 

select date '1992-09-02';

select DATE_TRUNC('year', date '2026/04/21');

/*using intervals
 * 
 * the function returns a date
 * 
 * now() - interval '30 days' means 30 days ago
 * now() - inteval '60 days' means 60 days ago
*/

select now()::date - interval '26 years';

--given that an exams release date is 14 days later, 
--please show the student id, exam id, exam date and release date

select result_id, student_id, exam_date, 
(exam_date + interval '14 days')::date as release_date from exam_results;


select to_char(exam_date,'Day, dd month yyyy') from exam_results;


select name from employees
union
select department_name from departments;
