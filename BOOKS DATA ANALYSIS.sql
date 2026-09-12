--TABLE CREATION & IMPORTING DATA

-- 1 Create Books table & Importing data 
DROP TABLE IF EXISTS Books;
CREATE TABLE IF NOT EXISTS Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

-- Import data
COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock) 
FROM 'D:\SQL Mastery - All Practice Files\SQL Project Practice File\Books_data.csv'
DELIMITER','
CSV HEADER;

-- Validating  Table
SELECT * FROM BOOKS;

-- 2 Create  Cutomers table & Importing data
DROP TABLE IF EXISTS Customers;
CREATE TABLE IF NOT EXISTS Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
-- Import Data
COPY Customers(Customer_ID, Name, Email, Phone, City, Country) 
FROM 'D:\SQL Mastery - All Practice Files\SQL Project Practice File\Customers_data.csv' 
DELIMITER','
CSV HEADER;

-- Validating  Table
SELECT * FROM CUSTOMERS;

--3 Create  Orders table & Importing data
DROP TABLE IF EXISTS orders;
CREATE TABLE IF NOT EXISTS Orders (
   Order_ID SERIAL PRIMARY KEY,
   Customer_ID INT REFERENCES Customers(Customer_ID),
   Book_ID INT REFERENCES Books(Book_ID),
   Order_Date DATE,
   Quantity INT,
   Total_Amount NUMERIC(10, 2)
);

--Import Data
COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount) 
FROM 'D:\SQL Mastery - All Practice Files\SQL Project Practice File\Orders_data.csv' 
DELIMITER','
CSV HEADER;

-- Validating  Table
SELECT * FROM ORDERS;

--PROJECT EXECUTION


-- 1) Retrieve all books in the "Fiction" genre:
SELECT *
FROM Books
WHERE Genre = 'Fiction';     -- Case Sensitive

------------------------

-- 2) Find books published after the year 1950:
SELECT *
FROM Books
WHERE Published_Year > 1950;

------------------------

-- 3) List all customers from the Canada:
SELECT *
FROM Customers
WHERE Country = 'Canada';   -- 3 customers

------------------------

-- 4) Show orders placed in November 2023:
SELECT *
FROM Orders 
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30';

------------------------

-- 5) Retrieve the total stock of books available:
SELECT SUM(Stock) AS Total_Stock
FROM Books;                        --25056

------------------------

-- 6) Find the details of the most expensive book:
SELECT *
FROM Books
ORDER BY Price DESC LIMIT 1;      -- Book Title -Proactive system-worthy orchestration

------------------------

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders WHERE Quantity > 1;   --Generalized Answer

SELECT C.Name,O.order_id,O.quantity
FROM Orders O
JOIN Customers C on O.Customer_id=C.Customer_id
WHERE Quantity >1                             -- Specific Columns
ORDER BY quantity DESC ;                      -- Optional

------------------------
-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT *
FROM Orders
WHERE Total_Amount > 20;

------------------------

-- 9) List all genres available in the Books table:
SELECT DISTINCT Genre
FROM Books;

------------------------

-- 10) Find the book with the lowest stock:
SELECT *
FROM Books
ORDER BY Stock LIMIT 1;      --Book Title - Networked systemic implementation

------------------------

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(Total_Amount) AS Total_Revenue
FROM Orders;

------------------------

--Advance Tier Questions

-- 1) Retrieve the total number of books sold for each genre:
SELECT B.Genre, SUM(O.Quantity) AS Total_Books_Sold
FROM Orders O
JOIN Books B ON O.Book_ID = B.Book_ID
GROUP BY B.Genre;

------------------------

-- 2) Find the average price of books in the "Fantasy" genre:

SELECT ROUND(AVG(Price),2) AS Average_Price
FROM Books
WHERE Genre = 'Fantasy';

------------------------

-- 3) List customers who have placed at least 2 orders:
SELECT O.Customer_ID,C.Name, COUNT(O.Order_ID) AS Order_Count
FROM Orders O
JOIN Customers C ON O.Customer_ID=C.Customer_ID
GROUP BY O.Customer_ID,C.Name
HAVING COUNT(O.Order_ID) >= 2
ORDER BY Customer_ID;          -- Optional

------------------------

-- 4) Find the most frequently ordered book:
SELECT O.Book_ID,B.Title, COUNT(O.Order_ID) AS Order_Count
FROM Orders O
JOIN Books B On O.Book_ID=B.Book_ID
GROUP BY O.Book_ID,B.Title
ORDER BY Order_Count DESC LIMIT 1;    --Robust tangible hardware

------------------------

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM Books 
WHERE Genre = 'Fantasy'
ORDER BY Price DESC LIMIT 3;

------------------------

-- 6) Retrieve the total quantity of books sold by each author:

SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author
ORDER BY Total_Books_Sold DESC;

------------------------

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.City,Total_Amount AS Amount_Spent
FROM Orders o
JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30
ORDER BY Total_Amount DESC;

------------------------

-- 8) Find the customer who spent the most on orders:
SELECT C.Customer_ID, C.Name, SUM(O.Total_Amount) AS Total_Spent
FROM Orders O
JOIN Customers C ON O.Customer_ID = C.Customer_ID
GROUP BY C.Customer_ID, C.Name
ORDER BY Total_Spent DESC LIMIT 1;       -- Customer Name - Kim Turner

------------------------

--9) Calculate the stock remaining after fulfilling all orders:

SELECT b.Book_ID, b.Title, b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Stock
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID;

--SECOND METHOD

SELECT B.Book_ID, B.Title, B.Stock, COALESCE(SUM(O.Quantity), 0) AS ordered_quantity, 
		B.Stock - COALESCE(SUM(O.Quantity), 0) AS Remaining_stock
FROM Books B
LEFT JOIN Orders O ON B.Book_ID = O.Book_ID
GROUP BY B.Book_ID
ORDER BY B.Book_ID;


