use new

create table employee(id int primary key,name varchar(50),branch varchar(50),salary float)
insert into employee(id,name,branch,salary)values(1,'Akash','mech',200000),(2,'bhanu','mech',300000),(3,'Aman','mech',150000),
(4,'Neel','cse',350000),(5,'mano','ece',100000)

insert into employee(id,name,branch)values(6,'Vikram','IT')





select *from employee

select *from employee where id=1
select *from employee where id!=1
select *from employee where id<>1
select *from employee where id>1
select *from employee where id <1
select *from employee where salary IS NOT NULL

select *from employee where name like'A%'
select *from employee where name like'%as%'and name not like 'V%'

SELECT *
FROM employee
WHERE salary = (SELECT MAX(salary) FROM employee);

select max(salary) from employee

SELECT id, name, salary
FROM Employee
WHERE salary BETWEEN 200000 AND 400000;

SELECT id, name, salary
FROM Employee
WHERE salary IN (SELECT salary FROM Employee WHERE salary >= 200000 AND salary <= 400000);

select MAX(salary) AS max_salary from Employee 

SELECT COUNT(*)
FROM Employee
WHERE salary = 100000;


select *from employee order by salary
select *from employee order by salary desc
select *from employee order by name Desc




select top 5 * from employee order  by salary desc

-- ASSIGNMENT (10-09-25) :

use Students

select*from books
select *from users
select *from orders

 

select count(*) price from books group by price
select top 5 * from books order by price desc
select *from books order by price desc offset 1 rows fetch next 3 rows only
select user_id ,count(*) as number_of_books from orders group by user_id having count(*) >=1
select user_id ,count(*) as number_of_books from orders group by user_id having count(*) >=1

 
--TOP N BOOKS PER USER:


 WITH user_book_price AS (
    SELECT 
        u.user_id,
        u.name AS user_name,
        b.product_id,
        b.title,
        b.price,
        ROW_NUMBER() OVER (PARTITION BY u.user_id ORDER BY b.price DESC) AS rn,
        RANK() OVER (PARTITION BY u.user_id ORDER BY b.price DESC) AS rnk,
        DENSE_RANK() OVER (PARTITION BY u.user_id ORDER BY b.price DESC) AS dense_rnk
    FROM orders o
    JOIN books b ON o.product_id = b.product_id
    JOIN users u ON o.user_id = u.user_id
)
SELECT *
FROM user_book_price
WHERE rn <= 2;


--RANKING USERS BY TOTAL SPENDINGS :

WITH user_spending AS (
    SELECT 
        u.user_id,
        u.name AS user_name,
        SUM(b.price) AS total_spent
    FROM orders o
    JOIN books b ON o.product_id = b.product_id
    JOIN users u ON o.user_id = u.user_id
    GROUP BY u.user_id, u.name
)
SELECT 
    user_id,
    user_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS rnk,
    DENSE_RANK() OVER (ORDER BY total_spent DESC) AS dense_rnk
FROM user_spending;