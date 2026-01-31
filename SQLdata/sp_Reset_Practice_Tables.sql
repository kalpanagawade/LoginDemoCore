CREATE PROCEDURE sp_Reset_Practice_Tables
AS
BEGIN
    -- DROP IF EXISTS
    IF OBJECT_ID('OrderP') IS NOT NULL DROP TABLE OrderP;
    IF OBJECT_ID('ProductP') IS NOT NULL DROP TABLE ProductP;
    IF OBJECT_ID('CustomerP') IS NOT NULL DROP TABLE CustomerP;

    -- CREATE CUSTOMER
    CREATE TABLE CustomerP
    (
        CustomerId INT IDENTITY PRIMARY KEY,
        CustomerName VARCHAR(100),
        Email VARCHAR(100),
        City VARCHAR(50)
    );

    -- CREATE PRODUCT
    CREATE TABLE ProductP
    (
        ProductId INT IDENTITY PRIMARY KEY,
        ProductName VARCHAR(100),
        Price DECIMAL(10,2)
    );

    -- CREATE ORDER
    CREATE TABLE OrderP
    (
        OrderId INT IDENTITY PRIMARY KEY,
        CustomerId INT,
        ProductId INT,
        OrderDate DATETIME DEFAULT GETDATE(),

        FOREIGN KEY (CustomerId) REFERENCES CustomerP(CustomerId),
        FOREIGN KEY (ProductId) REFERENCES ProductP(ProductId)
    );

    -- INSERT SAMPLE DATA
    INSERT INTO CustomerP VALUES
    ('Amit', 'amit@gmail.com', 'Mumbai'),
    ('Neha', 'neha@gmail.com', 'Pune');

    INSERT INTO ProductP VALUES
    ('Laptop', 55000),
    ('Mobile', 20000);

    INSERT INTO OrderP (CustomerId, ProductId)
    VALUES (1,1),(2,2);
END
