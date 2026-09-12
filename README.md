# 📚 Online Bookstore SQL Project

A PostgreSQL project built from raw CSV exports into a normalized schema, answering **20 real business queries** (basic + advanced).  
This project demonstrates **end-to-end SQL skills**: schema design, data loading, filtering, joins, grouping, and aggregation.

---

## 🚀 Project Overview
- **Data Sources**: `Books_data.csv`, `Customers_data.csv`, `Orders_data.csv`
- **Database**: PostgreSQL
- **Tables**: Books, Customers, Orders
- **Queries Executed**: 11 Basic + 9 Advanced
- **Goal**: Transform raw data into decision-ready insights for an online bookstore.

---

## 🗂 Database Schema

**Books**
- Book_ID (PK)  
- Title, Author, Genre, Published_Year  
- Price, Stock  

**Customers**
- Customer_ID (PK)  
- Name, Email, Phone, City, Country  

**Orders**
- Order_ID (PK)  
- Customer_ID (FK → Customers)  
- Book_ID (FK → Books)  
- Order_Date, Quantity, Total_Amount  

---

## ⚙️ Table Creation (DDL)

```sql
CREATE TABLE Books (
  Book_ID SERIAL PRIMARY KEY,
  Title VARCHAR(100),
  Author VARCHAR(100),
  Genre VARCHAR(50),
  Published_Year INT,
  Price NUMERIC(10,2),
  Stock INT
);

CREATE TABLE Customers (
  Customer_ID SERIAL PRIMARY KEY,
  Name VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(15),
  City VARCHAR(50),
  Country VARCHAR(150)
);

CREATE TABLE Orders (
  Order_ID SERIAL PRIMARY KEY,
  Customer_ID INT REFERENCES Customers(Customer_ID),
  Book_ID INT REFERENCES Books(Book_ID),
  Order_Date DATE,
  Quantity INT,
  Total_Amount NUMERIC(10,2)
);

## Basic Queries

 -- 1. Retrieve all books in the "Fiction" genre
SELECT * FROM Books WHERE Genre = 'Fiction';

-- 5. Total stock of books available
SELECT SUM(Stock) AS Total_Stock FROM Books;

-- 6. Most expensive book
SELECT * FROM Books ORDER BY Price DESC LIMIT 1;

-- 11. Total revenue generated
SELECT SUM(Total_Amount) AS Total_Revenue FROM Orders;

## Advance Queries

-- 1. Total number of books sold per genre
SELECT B.Genre, SUM(O.Quantity) AS Total_Books_Sold
FROM Orders O
JOIN Books B ON O.Book_ID = B.Book_ID
GROUP BY B.Genre;

-- 4. Most frequently ordered book
SELECT B.Title, COUNT(O.Order_ID) AS Order_Count
FROM Orders O
JOIN Books B ON O.Book_ID = B.Book_ID
GROUP BY B.Title
ORDER BY Order_Count DESC LIMIT 1;

-- 6. Total quantity of books sold per author
SELECT B.Author, SUM(O.Quantity) AS Total_Books_Sold
FROM Orders O
JOIN Books B ON O.Book_ID = B.Book_ID
GROUP BY B.Author
ORDER BY Total_Books_Sold DESC;

-- 8. Customer who spent the most
SELECT C.Name, SUM(O.Total_Amount) AS Total_Spent
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
GROUP BY C.Name
ORDER BY Total_Spent DESC LIMIT 1;

---
📊 Key Insights

Total Stock: 25,056 books available
Most Expensive Book: Proactive System-Worthy Orchestration
Lowest Stock Book: Networked Systemic Implementation
Top Customer: Kim Turner (highest spending)
Most Ordered Book: Robust Tangible Hardware
---

🧩 Skills Demonstrated

Schema design with primary & foreign keys
Bulk data import using COPY ... CSV HEADER
Filtering & sorting with WHERE, ORDER BY, LIMIT, DISTINCT
Aggregations with SUM, AVG, COUNT, ROUND
Multi-table joins (INNER JOIN, LEFT JOIN)
Grouping & conditions with GROUP BY, HAVING
---
## Source & Inspiration
- SkillCourse

## Author
- Amit Mohan Srivastav

