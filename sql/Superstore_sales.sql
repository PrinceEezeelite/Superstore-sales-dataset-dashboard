SELECT * FROM superstore_sales;

CREATE TABLE superstore_sales
 LIKE superstore_sales_dataset;
 
 INSERT superstore_sales
  SELECT *
    FROM superstore_sales_dataset;
    
 -- Convertine Order Date From Text TO Date Format   
SELECT
 `Order Date`,
  STR_TO_DATE(TRIM(`Order Date`), '%d/%m/%Y') AS Converted_date
FROM superstore_sales
WHERE `Order Date` IS NOT NULL;

-- Add a New Column
ALTER TABLE superstore_sales
ADD COLUMN Order_date DATE;

-- Fill it
UPDATE superstore_sales
SET Order_date = STR_TO_DATE(TRIM(`Order Date`), '%d/%m/%Y');

-- Drop Old Column
ALTER TABLE superstore_sales
Drop COLUMN `Order Date`;

-- Rename New Column
ALTER TABLE superstore_sales
CHANGE Order_date `Order Date` DATE;


 -- Convertine Ship Date From Text TO Date Format   
SELECT
 `Ship Date`,
  STR_TO_DATE(TRIM(`Ship Date`), '%d/%m/%Y') AS Converted_date
FROM superstore_sales
WHERE `Ship Date` IS NOT NULL;

-- Add a New Column
ALTER TABLE superstore_sales
ADD COLUMN Ship_date DATE;

-- Fill it
UPDATE superstore_sales
SET Ship_date = STR_TO_DATE(TRIM(`Ship Date`), '%d/%m/%Y');

-- Drop Old Column
ALTER TABLE superstore_sales
Drop COLUMN `Ship Date`;

-- Rename New Column
ALTER TABLE superstore_sales
CHANGE Ship_date `Ship Date` DATE;


-- Drop ï»¿Row ID Column
ALTER TABLE superstore_sales
Drop COLUMN `ï»¿Row ID`;

-- Convert Sales and Profit From Text to Number
SElect
   Sales,
   REPLACE(Sales, '$', '') AS Clean_Sales,
   CAST(REPLACE(Sales, '$', '')  AS DECIMAL(10,2)) AS Sale_Number
FROM superstore_sales;

SElect
   Profit,
   REPLACE(Profit, '$', '') AS Clean_Sales,
   CAST(REPLACE(Profit, '$', '')  AS DECIMAL(10,2)) AS Profit_Number
FROM superstore_sales;

-- Creating New Numeric Column
ALTER TABLE superstore_sales
ADD COLUMN Sales_New DECIMAL(10,2),
ADD COLUMN Profit_New DECIMAL(10,2);

-- Updating Column
UPDATE 
  superstore_sales
SET Sales_New = CAST(REPLACE(Sales, '$', '')  AS DECIMAL(10,2)),
    Profit_New = CAST(REPLACE(Profit, '$', '')  AS DECIMAL(10,2));
    
-- DROP old Column
ALTER TABLE superstore_sales
DROP COLUMN Sales,
DROP COLUMN Profit;

-- Renaming Column
ALTER TABLE superstore_sales
CHANGE Sales_New Sales DECIMAL(10,2),
CHANGE Profit_New Profit DECIMAL(10,2);

-- Total Revenue
SELECT  
  SUM(Sales) AS Total_Revenue
FROM superstore_sales;

-- Best Selling Product
ALTER TABLE superstore_sales
CHANGE `Sub-Category` Sub_Category VARCHAR(100);
SELECT Sub_Category,
  SUM(Quantity) AS  Units_Sold
FROM superstore_sales
GROUP BY Sub_Category
ORDER BY Units_Sold DESC;

-- sale by City
SELECT City,
  SUM(Sales) AS  Total_Sales
FROM superstore_sales
GROUP BY City;

