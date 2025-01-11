---SQL Queries
--Query 1: Retrieve Available Books
--Retrieve all books that are currently available for rent.

SELECT * FROM books 
WHERE status = 'yes';


 --Query 2: Find Members Registered After January 2024
--Find members who registered after January 1st, 2024.

SELECT * FROM members
WHERE reg_date > '2024-01-01';

--Query 3: Count Books in Each Category
--Count how many books are available in each category.

SELECT category, COUNT(*) AS total_books
FROM books
GROUP BY category;

-- Query 4: Find Books Rented by a Specific Member
--Find books rented by a specific member (e.g., 'M101').

SELECT * FROM issued_status
WHERE issued_member_id = 'M101';

 --Query 5: Books Rented in March 2024
--Find members who rented books in March 2024.

SELECT DISTINCT issued_member_id
FROM issued_status
WHERE issued_date BETWEEN '2024-03-01' AND '2024-03-31';

--Query 6: Count Rentals by Employee
--Count how many books an employee (e.g., 'E104') rented out.

SELECT issued_emp_id, COUNT(*) AS books_rented
FROM issued_status
WHERE issued_emp_id = 'E104'
GROUP BY issued_emp_id;

-- Query 7: Find Books Related to History
--Search for books related to the history category or title.

SELECT * FROM books
WHERE category LIKE '%History%' OR book_title LIKE '%History%';

-- Query 8: Average Salary of Employees in Branch 'B001'
--Find the average salary of employees in branch 'B001'.

SELECT AVG(salary) AS avg_salary
FROM employees
WHERE branch_id = 'B001';

-- Query 9: Books Rented More Than 5 Times
--Find books that have been rented more than five times.

SELECT issued_book_name, COUNT(*) AS rental_count
FROM issued_status
GROUP BY issued_book_name
HAVING COUNT(*) > 5;

--Query 10: Member Who Rented the Most Books
--Find the member who has rented the most books.

SELECT issued_member_id, COUNT(*) AS rental_count
FROM issued_status
GROUP BY issued_member_id
ORDER BY rental_count DESC
LIMIT 1;

-- Query 11: Employees Earning More Than Branch Average
--Find employees whose salary is higher than the average salary in their branch.

SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees AS sub_emp
    WHERE sub_emp.branch_id = employees.branch_id
);