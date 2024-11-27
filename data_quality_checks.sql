-- checking for null values--
SELECT COUNT(*) AS Null_Values
FROM sales_data
WHERE `Customer ID` IS NULL
   OR `Product ID` IS NULL
   OR `Sales Rep ID` IS NULL
   OR `Channel ID` IS NULL
   OR `Campaign ID` IS NULL
   OR `Lead Source ID` IS NULL;
   
-- checking for duplicates--
SELECT `Customer ID`, `Product ID`, `Sales Rep ID`, `Date`, COUNT(*) AS Dup_Count
FROM sales_data
GROUP BY `Customer ID`, `Product ID`, `Sales Rep ID`, `Date`
HAVING Dup_Count > 1;

-- Check for negative values in important fields like price, quantity, etc.
SELECT COUNT(*) AS Invalid_Sales_Values
FROM sales_data
WHERE `Sales Amount (USD)` < 0;

-- Check for invalid or inconsistent values in a categorical field
SELECT DISTINCT `Channel ID`
FROM sales_data
WHERE `Channel ID` NOT IN ('Online', 'In-Store');

-- Check if there are any records in sales_data that reference non-existing customers
SELECT COUNT(*) AS Invalid_Records
FROM sales_data
WHERE `Customer ID` NOT IN (SELECT `Customer ID` FROM customers);

-- Check for invalid references to non-existing products
SELECT COUNT(*) AS Invalid_Records
FROM sales_data
WHERE `Product ID` NOT IN (SELECT `Product ID` FROM products);

-- Check for non-numeric values in a numeric field (e.g., Sales Amount)
SELECT COUNT(*) AS Invalid_Numeric_Values
FROM sales_data
WHERE NOT `Sales Amount` REGEXP '^-?[0-9]+(?:\.[0-9]{1,2})?$';

-- Check for records with dates that are too old and could be considered inactive --
SELECT COUNT(*) AS Inactive_Records
FROM sales_data
WHERE `Sale Date` < '2022-01-01';

-- Check if you have records for all customers --
SELECT COUNT(DISTINCT `Customer ID`) AS Total_Customers
FROM sales_data;

-- Check FOR  missing products in sales records --
SELECT COUNT(DISTINCT `Product ID`) AS Total_Products
FROM sales_data;

-- Ensure critical columns are not missing data (e.g., Customer ID and Product ID)
SELECT COUNT(*) AS Missing_Critical_Data
FROM sales_data
WHERE `Customer ID` IS NULL OR `Product ID` IS NULL;


SELECT * FROM sales_data;