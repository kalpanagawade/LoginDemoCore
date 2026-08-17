CREATE TABLE SQLTopics (
    Id INT IDENTITY PRIMARY KEY,
    TopicName VARCHAR(50),
    TopicContent NVARCHAR(MAX),
	Language Varchar(50)
);

INSERT INTO SQLTopics (TopicName, TopicContent,Language)
VALUES 

('SQLBasics', '-- ================= SQL BASICS =================

-- 1️⃣ Definition:
-- SQL (Structured Query Language) is used to create, read, update, and delete data in a database.

-- 2️⃣ Explanation:
-- SQL works with tables (rows and columns). You can create tables, insert data, query data, update data, and delete data.

-- 3️⃣ Basic SQL Syntax:

-- SELECT: Retrieve data
SELECT * FROM CustomerP;
SELECT ProductName, Price FROM ProductP;

-- INSERT: Add new data
INSERT INTO CustomerP (CustomerName, Email, City)
VALUES (''Amit'', ''amit@gmail.com'', ''Mumbai'');

INSERT INTO ProductP (ProductName, Price)
VALUES (''Laptop'', 55000);

-- UPDATE: Modify existing data
UPDATE ProductP
SET Price = 60000
WHERE ProductName = ''Laptop'';

-- DELETE: Remove data
DELETE FROM CustomerP
WHERE CustomerName = ''Amit'';

-- 4️⃣ Example Query: JOIN
SELECT c.CustomerName, p.ProductName, o.Quantity, o.OrderDate
FROM OrderP o
INNER JOIN CustomerP c ON o.CustomerId = c.CustomerId
INNER JOIN ProductP p ON o.ProductId = p.ProductId;

-- 5️⃣ Aggregate Functions:
SELECT COUNT(*) AS TotalCustomers FROM CustomerP;
SELECT SUM(Price) AS TotalProductValue FROM ProductP;
SELECT AVG(Price) AS AveragePrice FROM ProductP;

-- 6️⃣ Sorting:
SELECT * FROM ProductP
ORDER BY Price DESC;

-- 7️⃣ Filtering:
SELECT * FROM CustomerP
WHERE City = ''Mumbai'';','SQL'),


('CRUD', '-- INSERT CUSTOMER
INSERT INTO CustomerP (CustomerName, Email)
VALUES (''Rahul'', ''rahul@gmail.com'');

-- INSERT PRODUCT
INSERT INTO ProductP (ProductName, Price)
VALUES (''Laptop'', 55000);

-- INSERT ORDER
INSERT INTO OrderP (CustomerId, ProductId, Quantity, OrderDate)
VALUES (1, 1, 2, GETDATE());

-- SELECT
SELECT * FROM CustomerP;
SELECT * FROM ProductP;
SELECT * FROM OrderP;

-- UPDATE
UPDATE ProductP
SET Price = 60000
WHERE ProductId = 1;

-- DELETE
DELETE FROM OrderP WHERE OrderId = 1;','SQL'),


('Joins', '-- INNER JOIN
SELECT
    c.CustomerName,
    p.ProductName,
    o.Quantity,
    o.OrderDate
FROM OrderP o
INNER JOIN CustomerP c ON o.CustomerId = c.CustomerId
INNER JOIN ProductP p ON o.ProductId = p.ProductId;

-- LEFT JOIN
SELECT c.CustomerName, o.OrderId
FROM CustomerP c
LEFT JOIN OrderP o ON c.CustomerId = o.CustomerId;','SQL'),


('Functions', '-- COUNT
SELECT COUNT(*) AS TotalCustomers FROM CustomerP;

-- SUM
SELECT SUM(Price) AS TotalProductValue FROM ProductP;

-- AVG
SELECT AVG(Price) AS AvgPrice FROM ProductP;

-- DATE FUNCTION
SELECT OrderId, YEAR(OrderDate) AS OrderYear
FROM OrderP;','SQL'),


('Procedures', '-- CREATE PROCEDURE
CREATE PROCEDURE sp_GetOrders
AS
BEGIN
    SELECT
        c.CustomerName,
        p.ProductName,
        o.Quantity,
        o.OrderDate
    FROM OrderP o
    JOIN CustomerP c ON o.CustomerId = c.CustomerId
    JOIN ProductP p ON o.ProductId = p.ProductId
END;

-- EXECUTE
EXEC sp_GetOrders;','SQL');
