-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Country VARCHAR(50)
);

-- Create Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2)
);

-- Create Sales Table
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


-- Insert data into Customers Table
INSERT INTO Customers (CustomerID, Name, Email, Country) VALUES
(1, 'John Doe', 'john@example.com', 'USA'),
(2, 'Jane Smith', 'jane@example.com', 'Canada'),
(3, 'Samuel Green', 'samuel@example.com', 'USA');

-- Insert data into Products Table
INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 499.99),
(3, 'Table', 'Furniture', 199.99);

-- Insert data into Sales Table
INSERT INTO Sales (SaleID, CustomerID, ProductID, Quantity, SaleDate) VALUES
(1, 1, 1, 2, '2023-01-15'),
(2, 2, 2, 1, '2023-02-20'),
(3, 1, 3, 1, '2023-03-10'),
(4, 3, 1, 1, '2023-04-05'),
(5, 2, 3, 3, '2023-05-15');


SELECT 
    C.Name AS CustomerName,
    SUM(P.Price * S.Quantity) AS TotalSales
FROM 
    Sales S
    JOIN Customers C ON S.CustomerID = C.CustomerID
    JOIN Products P ON S.ProductID = P.ProductID
GROUP BY 
    C.Name;

SELECT 
    P.ProductName,
    SUM(P.Price * S.Quantity) AS TotalSales
FROM 
    Sales S
    JOIN Products P ON S.ProductID = P.ProductID
GROUP BY 
    P.ProductName;
    
-- Top 3 Customers by Sales
SELECT 
    C.Name AS CustomerName,
    SUM(P.Price * S.Quantity) AS TotalSales
FROM 
    Sales S
    JOIN Customers C ON S.CustomerID = C.CustomerID
    JOIN Products P ON S.ProductID = P.ProductID
GROUP BY 
    C.Name
ORDER BY 
    TotalSales DESC
LIMIT 3;

-- Sales by Country
SELECT 
    C.Country,
    SUM(P.Price * S.Quantity) AS TotalSales
FROM 
    Sales S
    JOIN Customers C ON S.CustomerID = C.CustomerID
    JOIN Products P ON S.ProductID = P.ProductID
GROUP BY 
    C.Country;
    
SELECT 
    C.Name AS CustomerName,
    AVG(P.Price * S.Quantity) AS AverageSale
FROM 
    Sales S
    JOIN Customers C ON S.CustomerID = C.CustomerID
    JOIN Products P ON S.ProductID = P.ProductID
GROUP BY 
    C.Name;


SELECT 
    C.Name AS CustomerName,
    SUM(P.Price * S.Quantity) AS TotalSales
FROM 
    Sales S
    JOIN Customers C ON S.CustomerID = C.CustomerID
    JOIN Products P ON S.ProductID = P.ProductID
GROUP BY 
    C.Name
ORDER BY 
    TotalSales DESC
LIMIT 1;


SELECT 
    P.ProductName,
    (SUM(P.Price * S.Quantity) / (SELECT SUM(P.Price * S.Quantity) 
    FROM Sales S JOIN Products P ON S.ProductID = P.ProductID)) * 100 AS SalesContributionPercentage
FROM 
    Sales S
    JOIN Products P ON S.ProductID = P.ProductID
GROUP BY 
    P.ProductName
ORDER BY 
    SalesContributionPercentage DESC;




