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

## 2. **Inserting Records into Tables**

### **2.1 Inserting Data into Books Table**

```sql
INSERT INTO books (book_id, book_title, author_name, category, status)
VALUES
(1, 'To Kill a Mockingbird', 'Harper Lee', 'Fiction', 'yes'),
(2, '1984', 'George Orwell', 'Dystopian', 'no'),
(3, 'The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 'yes');
```

### **2.2 Inserting Data into Members Table**

```sql
INSERT INTO members (member_id, member_name, reg_date)
VALUES
('M101', 'Alice Smith', '2023-05-15'),
('M102', 'John Doe', '2024-01-10');
```

### **2.3 Inserting Data into Issued Status Table**

```sql
INSERT INTO issued_status (issue_id, issued_member_id, issued_book_name, issued_date, return_date, issued_emp_id)
VALUES
(1, 'M101', 'To Kill a Mockingbird', '2024-01-05', '2024-01-15', 'E101'),
(2, 'M102', '1984', '2024-01-07', '2024-01-14', 'E102');
```

---

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



LinkedIn: Connect with me professionaly https://www.linkedin.com/in/abhi-sunchu/
Thank you for your interest in this project!

