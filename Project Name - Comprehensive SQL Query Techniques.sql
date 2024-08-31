
-- PROJECT NAME - Comprehensive SQL Query Techniques: Ranking, Joins, and Performance Optimization

CREATE DATABASE SQL_QUESTIONS
USE SQL_QUESTIONS

-- Create Table
CREATE TABLE Emp
(
EmployeeID INT PRIMARY KEY,
Name VARCHAR(50),
Salary DECIMAL(10,2),
Department VARCHAR(50)
)
-- Insert the Data
INSERT INTO Emp VALUES(1,'Vickey Verma',60000,'IT'),
(2,'Nitin Kumar',75000,'HR'),
(3,'Ashish Sharma', 80000,'IT'),
(4,'Ravi Sharma',65000,'Finance'),
(5,'Vivek Malhotra',82000,'Supply chain')

Select * from Emp

--Q1 - Ranking Functions and ORDER BY Queries
--Ranking Functions
-- Ranking functions are used to assign a unique rank to each row within a partition of a result set. Common ranking functions include,
-- ROW_NUMBER(), RANK(), and DENSE_RANK().

SELECT
     EmployeeID,
	 Name,
	 Salary,
	 Department,
	 ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RowNum,
	 RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS Rank,
	 DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS DenseRank
FROM Emp

-- Create Table
CREATE TABLE Orders
(
OrderID INT PRIMARY KEY,
CustomerID INT,
OrderDate Date
)
INSERT INTO Orders VALUES(1,1,'2024-01-10'),
(2,2,'2024-01-15'),
(3,3,'2024-02-01'),
(4,4,'2024-02-10'),
(5,5,'2024-02-15')

Select * from Orders

-- Create Table
CREATE TABLE Customer
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(50)
)
INSERT INTO Customer VALUES(1,'Kevin Peterson'),
(2,'Robin Uttapa'),
(3,'Virender Sehwag'),
(4,'Sachin Tendulkar'),
(5,'Brain Lara')

Select * from Customer

--Q2- JOINs and GROUP BY Queries
--Joins - Joins are used to combine rows from two or more tables based on a related column between them.

SELECT
     Orders.OrderID,
	 Customer.CustomerName,
	 Orders.OrderDate
From Orders
JOIN Customer on Orders.CustomerID = Customer.CustomerID
	 

--Group BY - The GROUP BY clause groups rows that have the same values into summary rows.

SELECT
     CustomerID,
	 COUNT(OrderID) AS NumberofOrders
From Orders
Group by CustomerID

--Q3- Difference Between UNION and UNION ALL
-- UNION removes duplicate rows from the result set.
-- UNION ALL includes all rows, even if they are duplicates.

--Create Table
CREATE TABLE A
(
Value INT
)


CREATE TABLE B
(
Value INT
)

INSERT INTO A VALUES (1),(2),(3)
INSERT INTO B VALUES (2),(3),(4)

Select * from A
Select * from B

--Union Query

Select Value From A
UNION
Select Value From B

--Union All

Select Value From A
UNION ALL
Select Value From B

--Q4- Why Use Stored Procedures
-- A- Encapsulation: Encapsulate complex operations in a single callable procedure.
-- B- Performance: Improve performance by reducing network traffic and allowing SQL Server to optimize execution.
-- C- Security: Restrict direct access to the database tables and use procedures for access control.
-- D- Reusability: Reuse the same code for various applications or user

--Create a Stored Procedure
CREATE PROCEDURE GETEmployeeDepartment
@Department VARCHAR(50)
AS
BEGIN
    SELECT * FROM Emp
	WHERE Department = @Department
END

EXEC GETEmployeeDepartment 'Supply Chain'

--5 -Resource Consumption: GROUP BY vs ORDER BY
--GROUP BY: Aggregates data into groups and can be resource-intensive if dealing with large datasets due to the need to group and,
-- aggregate

--ORDER BY: Sorts the result set based on one or more columns, which can also be resource-intensive due to the sorting operation.

-- Which Has Greater Resource Consumption?

-- GROUP BY typically has greater resource consumption compared to ORDER BY because it involves additional processing for aggregations.
-- However, the actual resource consumption can vary based on the specific query and data volume.

-- GROUP BY
SELECT Department, COUNT(*) AS NumberofEmployee
From Emp
GROUP BY Department


-- ORDER BY
SELECT * FROM Emp
ORDER BY Salary DESC
