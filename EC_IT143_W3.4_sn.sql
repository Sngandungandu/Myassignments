/*****************************************************************************************************************
NAME:    EC_IT143_W3.4_sn.sql
PURPOSE: AdventureWorks SQL answers for 8 selected questions across 4 complexity categories.

MODIFICATION LOG:
Ver      Date        Author        Description
-----    ----------  -----------   -------------------------------------------------------------------------------
1.0      2026-11-22  S. Ngandu     Initial script for 3.4 Adventure Works—Create Answers.

RUNTIME: ~1s
NOTES:   Run against AdventureWorks database in SQL Server.
******************************************************************************************************************/

-- Q1 [Business User - Marginal complexity]
-- Question: How many products do we have? (Author: Adam Claycamp)
SELECT
    COUNT(*) AS TotalProducts
FROM Production.Product;


-- Q2 [Business User - Marginal complexity]
-- Question: What is the total number of distinct product subcategories listed in our catalog? (Author: Serge Ngandu)
SELECT
    COUNT(DISTINCT ProductSubcategoryID) AS DistinctProductSubcategories
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;


-- Q3 [Business User - Moderate complexity]
-- Question: I am reviewing our bike lineup and categories. How many product subcategories belong to the Bikes? (Author: Adam Claycamp)
SELECT
    COUNT(*) AS BikeSubcategoryCount
FROM Production.ProductSubcategory AS psc
INNER JOIN Production.ProductCategory AS pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE pc.Name = 'Bikes';


-- Q4 [Business User - Moderate complexity]
-- Question: Management wants to evaluate sales territory performance. Which sales territories produced the highest total sales amounts and how many sales orders came from each territory? (Author: Godwin Kpodovia)
SELECT
    st.Name AS TerritoryName,
    COUNT(soh.SalesOrderID) AS TotalOrders,
    SUM(soh.TotalDue) AS TotalSalesAmount
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.SalesTerritory AS st
    ON soh.TerritoryID = st.TerritoryID
GROUP BY
    st.Name
ORDER BY
    TotalSalesAmount DESC;


-- Q5 [Business User - Increased complexity]
-- Question: Our sales team is planning a promotion for next quarter. Before we make a choice, I need to know how many orders were placed in 2013. Please give me one number that counts every order placed during that year. (Author: Adam Claycamp)
SELECT
    COUNT(*) AS OrdersIn2013
FROM Sales.SalesOrderHeader
WHERE OrderDate >= '2013-01-01'
  AND OrderDate < '2014-01-01';


-- Q6 [Business User - Increased complexity]
-- Question: A new regional manager is joining us and wants to understand our customers. She asked which sales territory has the most customers. Tell me the name of the territory with the largest number of customers? Just the name. (Author: Adam Claycamp)
SELECT TOP (1)
    st.Name AS TerritoryName
FROM Sales.Customer AS c
INNER JOIN Sales.SalesTerritory AS st
    ON c.TerritoryID = st.TerritoryID
GROUP BY
    st.Name
ORDER BY
    COUNT(c.CustomerID) DESC;


-- Q7 [Metadata - System Information Schema Views]
-- Question: Which AdventureWorks tables contain a column named ProductID, and what data type is defined for that column? (Author: Godwin Kpodovia)
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'ProductID'
ORDER BY
    TABLE_SCHEMA,
    TABLE_NAME;


-- Q8 [Metadata - System Information Schema Views]
-- Question: Using INFORMATION_SCHEMA views, which columns exist in the Sales.SalesOrderHeader table and which of those columns allow NULL values? (Author: Godwin Kpodovia)
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'Sales'
  AND TABLE_NAME = 'SalesOrderHeader'
ORDER BY
    ORDINAL_POSITION;