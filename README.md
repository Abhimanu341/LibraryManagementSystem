# SQL Library Management System

This repository demonstrates how to create tables, insert records, and perform various SQL queries to manage a library system. Below is a step-by-step guide for each part of the process.

![pic_LMS](https://github.com/user-attachments/assets/e79efcd0-b9da-4110-b8dc-cf7875cc5db7)


**Project Title**: Library Management System
## 1. **Creating Tables**

### **1.1 Create Books Table**

The `books` table stores details about the books available in the library.

```sql
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(255),
    author_name VARCHAR(255),
    category VARCHAR(100),
    status VARCHAR(50) -- 'yes' for available, 'no' for unavailable
);
```

- **book_id:** Unique identifier for each book.
- **book_title:** The title of the book.
- **author_name:** The author of the book.
- **category:** Category/genre of the book (e.g., Fiction, Non-fiction).
- **status:** Indicates whether the book is available for rent.

### **1.2 Create Members Table**

The `members` table holds details about library members.

```sql
CREATE TABLE members (
    member_id VARCHAR(10) PRIMARY KEY,
    member_name VARCHAR(255),
    reg_date DATE
);
```

- **member_id:** Unique identifier for each member.
- **member_name:** Name of the member.
- **reg_date:** Registration date of the member.

### **1.3 Create Issued Status Table**

The `issued_status` table stores the rental status for each book issued to a member.

```sql
CREATE TABLE issued_status (
    issue_id INT PRIMARY KEY,
    issued_member_id VARCHAR(10),
    issued_book_name VARCHAR(255),
    issued_date DATE,
    return_date DATE,
    issued_emp_id VARCHAR(10),
    FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
    FOREIGN KEY (issued_book_name) REFERENCES books(book_title)
);
```

- **issue_id:** Unique identifier for each rental transaction.
- **issued_member_id:** The member who rented the book.
- **issued_book_name:** The name of the book that was issued.
- **issued_date:** The date when the book was issued.
- **return_date:** The date when the book was returned.
- **issued_emp_id:** The employee who processed the rental transaction.

---

Here's a comprehensive explanation with your updated tasks for the Library Management System CRUD operations:

---

## CRUD Operations

### 1. **Create: Inserted Sample Records into the Books Table**
In this task, you are creating a new book record by inserting data into the `books` table. This is a `CREATE` operation.

#### SQL Query:
```sql
INSERT INTO books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM books;
```
Explanation: 
- The above query inserts a new book record with ISBN `978-1-60129-456-2`, the title 'To Kill a Mockingbird', category 'Classic', rental price `6.00`, status 'yes' (indicating the book is available), author 'Harper Lee', and publisher 'J.B. Lippincott & Co.' into the `books` table.
- The `SELECT * FROM books` query displays all the books, including the newly inserted record.

---

### 2. **Update: Update an Existing Member's Address**
This task focuses on updating an existing record in the `members` table to modify a member's address.

#### SQL Query:
```sql
UPDATE members 
SET member_address = '125 Oak St' 
WHERE member_id = 'C103';
```
Explanation:
- This query updates the address of the member with `member_id = 'C103'` to '125 Oak St' in the `members` table.

---

### 3. **Delete: Remove a Record from the Issued Status Table**
This task involves removing a record from the `issued_status` table. 

#### SQL Query:
```sql
DELETE FROM issued_status 
WHERE issued_id = 'IS121';
```
Explanation:
- The query deletes the record with `issued_id = 'IS121'` from the `issued_status` table.

---

### 4. **Retrieve: All Books Issued by a Specific Employee**
This task retrieves all the books issued by a specific employee, identified by `emp_id`.

#### SQL Query:
```sql
SELECT * FROM issued_status 
WHERE issued_emp_id = 'E101';
```
Explanation:
- This query retrieves all records from the `issued_status` table where the `issued_emp_id` is 'E101', thus showing the books issued by this specific employee.

---

### 5. **List: Members Who Have Issued More Than One Book**
This task uses the `GROUP BY` clause to find members who have issued more than one book. It involves grouping the data by `issued_emp_id` and counting the number of books issued by each employee.

#### SQL Query:
```sql
SELECT issued_emp_id, COUNT(*) 
FROM issued_status 
GROUP BY issued_emp_id 
HAVING COUNT(*) > 1;
```
Explanation:
- This query groups the `issued_status` table by `issued_emp_id`, counts how many books were issued by each employee, and then filters the results to only show employees who have issued more than one book.

---

These operations cover essential CRUD tasks that help manage the library system's data, including inserting, updating, deleting, and retrieving records in a structured manner. You can use similar SQL queries for your own LMS implementation and adjust them as needed.
## 3. **SQL Queries**

### **3.1 Query 1: Retrieve Available Books**

Retrieve all books that are currently available for rent.

```sql
SELECT * FROM books 
WHERE status = 'yes';
```

- **Explanation:** This query retrieves all columns from the `books` table where the `status` is 'yes', meaning the book is available.

---

### **3.2 Query 2: Find Members Registered After January 2024**

Find members who registered after January 1st, 2024.

```sql
SELECT * FROM members
WHERE reg_date > '2024-01-01';
```

- **Explanation:** This query filters members who registered after January 1st, 2024, by checking the `reg_date`.

---

### **3.3 Query 3: Count Books in Each Category**

Count how many books are available in each category.

```sql
SELECT category, COUNT(*) AS total_books
FROM books
GROUP BY category;
```

- **Explanation:** This query groups books by their category and counts how many books exist in each category using `COUNT()`.

---

### **3.4 Query 4: Find Books Rented by a Specific Member**

Find books rented by a specific member (e.g., 'M101').

```sql
SELECT * FROM issued_status
WHERE issued_member_id = 'M101';
```

- **Explanation:** This query retrieves all rentals for member 'M101' by filtering the `issued_status` table using `issued_member_id`.

---

### **3.5 Query 5: Books Rented in March 2024**

Find members who rented books in March 2024.

```sql
SELECT DISTINCT issued_member_id
FROM issued_status
WHERE issued_date BETWEEN '2024-03-01' AND '2024-03-31';
```

- **Explanation:** This query retrieves the unique member IDs of those who rented books in March 2024 by filtering based on the `issued_date`.

---

### **3.6 Query 6: Count Rentals by Employee**

Count how many books an employee (e.g., 'E104') rented out.

```sql
SELECT issued_emp_id, COUNT(*) AS books_rented
FROM issued_status
WHERE issued_emp_id = 'E104'
GROUP BY issued_emp_id;
```

- **Explanation:** This query counts how many books employee 'E104' has rented out by grouping the data by `issued_emp_id`.

---

### **3.7 Query 7: Find Books Related to History**

Search for books related to the history category or title.

```sql
SELECT * FROM books
WHERE category LIKE '%History%' OR book_title LIKE '%History%';
```

- **Explanation:** This query retrieves books whose category or title contains 'History', using the `LIKE` operator and the `%` wildcard.

---

### **3.8 Query 8: Average Salary of Employees in Branch 'B001'**

Find the average salary of employees in branch 'B001'.

```sql
SELECT AVG(salary) AS avg_salary
FROM employees
WHERE branch_id = 'B001';
```

- **Explanation:** This query calculates the average salary of employees in a specific branch using the `AVG()` function.

---

### **3.9 Query 9: Books Rented More Than 5 Times**

Find books that have been rented more than five times.

```sql
SELECT issued_book_name, COUNT(*) AS rental_count
FROM issued_status
GROUP BY issued_book_name
HAVING COUNT(*) > 5;
```

- **Explanation:** This query counts the number of rentals for each book and filters to include only those rented more than five times.

---

### **3.10 Query 10: Member Who Rented the Most Books**

Find the member who has rented the most books.

```sql
SELECT issued_member_id, COUNT(*) AS rental_count
FROM issued_status
GROUP BY issued_member_id
ORDER BY rental_count DESC
LIMIT 1;
```

- **Explanation:** This query counts the rentals per member, orders the results in descending order by rental count, and returns the member who rented the most books.

---

### **3.11 Query 11: Employees Earning More Than Branch Average**

Find employees whose salary is higher than the average salary in their branch.

```sql
SELECT emp_id, emp_name, salary
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees AS sub_emp
    WHERE sub_emp.branch_id = employees.branch_id
);
```

- **Explanation:** This subquery calculates the average salary in each branch, and the main query finds employees who earn more than the average in their respective branches.

---

## 4. **Conclusion**

The above queries help manage and analyze data within a library system, from tracking available books to understanding rental patterns, member activity, and employee performance. You can modify these queries to fit your specific needs and extend the database for more complex library management features.


Author - Sunchu Abhishek


This project showcases SQL skills essential for database management and analysis. For more content on SQL and data analysis, connect with me through the following channels:

THANK YOU FOR THE DATASET RESOURCES---https://www.youtube.com/watch?v=6X2-P9fNVvw&list=LL&index=6

LinkedIn: Connect with me professionaly https://www.linkedin.com/in/abhi-sunchu/
Thank you for your interest in this project!

