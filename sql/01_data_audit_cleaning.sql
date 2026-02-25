-- ===================================================
-- 01_data_audit_cleaning.sql 
-- Purpose: Quick audit and define valid product sales
-- ===================================================

USE online_retail; 

-- 1) Basic dataset checks 
SELECT COUNT(*) AS total_rows 
FROM online_retail_ii; 

-- Get min date and max. 2009-12-01 to 2011-12-09 
SELECT 
  MIN(InvoiceDate) AS min_date,
  MAX(InvoiceDate) AS max_date
FROM online_retail_ii;

-- Get min | max price 
SELECT 
	MIN(Price) AS min_price, 
    MAX(Price) AS max_price
FROM online_retail_ii; 
-- Min Price is -53594

SELECT 
	SUM(CASE WHEN CustomerID IS NULL OR CustomerID = '' THEN 1 ELSE 0 END) AS missnig_customer_id 
FROM online_retail_ii; 

-- 2) Cancellations vs negative price investigation 
SELECT 
	SUM(CASE WHEN Invoice LIKE 'C%' THEN 1 ELSE 0 END)AS cancelled_rows, 
    SUM(CASE WHEN Price < 0 THEN 1 ELSE 0 END) AS negative_price_row, 
    SUM(CASE WHEN Invoice LIKE 'C%' AND Price <0 THEN 1 ELSE 0 END) AS cancelled_and_negative_rows 
FROM online_retail_ii; 

-- Check negative price rows (bad debt adjustment) 
SELECT *
FROM online_retail_ii
WHERE Price < 0;

-- 3) Define valid product sales (Product Revenue only) 
-- - Not cancelled 
-- - Quantity > 0 AND Price > 0 
-- - StockCode is numeric (filters out postage, fees, manual entry, etc) 
-- - StockCode is not empty 
DROP VIEW IF EXISTS view_valid_sales;

CREATE VIEW view_valid_sales AS
SELECT
  *,
  (Quantity * Price) AS revenue
FROM online_retail_ii
WHERE Invoice NOT LIKE 'C%'
  AND Quantity > 0
  AND Price > 0
  AND StockCode IS NOT NULL
  AND StockCode <> ''
  AND StockCode REGEXP '^[0-9]+$';
  
  SELECT COUNT(*) AS valid_rows
  FROM view_valid_sales; 
