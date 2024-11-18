create database library_project;
use library_project;

DROP TABLE IF EXISTS branch;
CREATE TABLE branch
(
            branch_id VARCHAR(10) PRIMARY KEY,
            manager_id VARCHAR(10),
            branch_address VARCHAR(30),
            contact_no VARCHAR(15)
);

DROP TABLE IF EXISTS members;
CREATE TABLE members
(
            member_id VARCHAR(10) PRIMARY KEY,
            member_name VARCHAR(30),
            member_address VARCHAR(30),
            reg_date DATE
);
CREATE TABLE books
(
            isbn VARCHAR(50) PRIMARY KEY,
            book_title VARCHAR(80),
            category VARCHAR(30),
            rental_price DECIMAL(10,2),
            status VARCHAR(10),
            author VARCHAR(30),
            publisher VARCHAR(30)
);
DROP TABLE IF EXISTS issued_status;
CREATE TABLE return_status
(
            return_id VARCHAR(10) PRIMARY KEY,
            issued_id VARCHAR(30),
            return_book_name VARCHAR(80),
            return_date DATE,
            return_book_isbn VARCHAR(50),
            FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);

select*from return_status;
select*from books
where isbn='978-1-60129-456-2';
-- Q1.create a new book record?--
insert into books(isbn,book_title,category,rental_price, status, author,publisher)
values
('978-1-60129-456-2','To Kill a Mockingbird','Classic',6.00,'yes','Harper lee','J.B.Lippincott & Co.');
-- Q2 update existing memeber adress?--
update members
set member_address='125 main St'
where member_id='C101';
-- Q3 DELETE A RECORD FROM THE ISSUED STATUS TABLE WITH ISSUED ID IS121
SELECT*FROM ISSUED_STATUS
WHERE ISSUED_ID ='IS121';
DELETE FROM ISSUED_STATUS
WHERE ISSUED_ID ='IS121';
-- Q4 RETRIEVE ALL BOOKS ISSUED BY SPECIFIC EMPLOY EMPLOY ID IS E101?--
SELECT *FROM ISSUED_STATUS 
WHERE ISSUED_EMP_ID ='E101' ;
-- Q5  LIST MEMBER WHO HAVE ISSUED MORE THAN  ONE BOOK?--
SELECT 
I.issued_emp_id,
e.emp_name
from issued_status as I
join
employees as e
on e.emp_id=I.issued_emp_id
group by 1,2
having count(I.issued_id)>1;
-- Q6 CREATE SUMMARY TABLE  USED CTAS TO GENERATE  NEW TABLES BASED ON QUERY RESULTS EACH BOOK AND TOTAL BOOK ISSUED COUNT
CREATE TABLE BOOK_CNTS
AS
SELECT 
B.ISBN,
B.BOOK_TITLE,
COUNT(IST.ISSUED_ID )AS NO_ISSUED
FROM BOOKS AS B
JOIN
ISSUED_STATUS AS IST 
ON IST.ISSUED_BOOK_ISBN = B.ISBN
GROUP BY  1,2; 
SELECT * FROM BOOK_CNTS;
 -- Q7 RETRIEVE  ALL BOOKS IN A SPECIFIC CATEGORY
 SELECT * FROM BOOKS
 WHERE CATEGORY ='CLASSIC';
  -- Q8 FIND TOTAL RENTAL  INCOME BY  CATEGORY?--
  SELECT 
  B.CATEGORY, 
  SUM(B.rental_price),
  count(*)
  from books as B
  join 
  issued_status as ist 
  on ist.issued_book_isbn=b.isbn
  group by 1;
  -- Q9 LIST MEMBER WHO REGISTERED IN LAST  180 DAYS --
  SELECT * FROM MEMBERS
  WHERE REG_DATE >= CURRENT_DATE() - INTERVAL 180 DAY;
  
-- Q10  LIST EMPLOYEES WITH THEIR BRANCH MANAGER'S  NAME ANDTHEIR BRANCH DETAIL--
SELECT
E1.*,
B.MANAGER_ID,
E2.EMP_NAME AS MANAGER
FROM EMPLOYEES AS E1
JOIN
 BRANCH AS B
 ON B.BRANCH_ID=E1.BRANCH_ID
 JOIN
 EMPLOYEES AS E2
 ON B.MANAGER_ID = E2.EMP_ID;
 -- Q11 CREATE A TABLE OF  BOOKS  WITH RENTAL  PRICE ABOVE  A CERTAIN THRESHOLD 7USD--
 CREATE TABLE BOOKS_PRICE_GREATER_THAN_SEVEN
 AS
 SELECT * FROM BOOKS
 WHERE RENTAL_PRICE>7;
SELECT 
    *
FROM
    BOOKS_PRICE_GREATER_THAN_SEVEN;
-- Q12 RETRIEVE THE LIST OF BOOKS NOT YET  RETURNED  --
SELECT
 DISTINCT IST.ISSUED_BOOK_NAME
 FROM ISSUED_STATUS AS IST
 LEFT JOIN 
 RETURN_STATUS AS RS 
 ON IST.ISSUED_ID=RS.ISSUED_ID
 WHERE RS.RETURN_ID IS NULL;
 SELECT * FROM RETURN_STATUS
 
 
 
    
    
   