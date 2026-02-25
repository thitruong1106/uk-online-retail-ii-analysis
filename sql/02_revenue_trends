-- ===================================================
-- 02_revenue_trends.sql
-- Purpose: Revenue performance over time (Product Revenue Only)
-- Source: view_valid_sales (created in 01_data_audit_cleaning.sql)
-- ===================================================

USE online_retail;

-- 1) Overall revenue + volume metrics
SELECT
  SUM(revenue) AS total_revenue,
  COUNT(DISTINCT Invoice) AS total_orders,
  COUNT(*) AS total_line_items,
  AVG(revenue) AS avg_line_item_revenue
FROM view_valid_sales;

-- 2) Monthly revenue trend (Year-Month)
-- Using the DATE_FORMAT expression directly in GROUP BY (MySQL-safe)
SELECT
  YEAR(InvoiceDate) AS year,
  MONTH(InvoiceDate) AS month,
  SUM(revenue) AS monthly_revenue,
  COUNT(DISTINCT Invoice) AS monthly_orders,
  COUNT(*) AS monthly_line_items,
  AVG(revenue) AS avg_line_item_revenue
FROM view_valid_sales
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY YEAR(InvoiceDate), MONTH(InvoiceDate);

-- 3) Quarterly summary
WITH valid_sales AS (
  SELECT
    Invoice,
    InvoiceDate,
    revenue,
    YEAR(InvoiceDate) AS year,
    MONTH(InvoiceDate) AS month,
    CASE
      WHEN MONTH(InvoiceDate) IN (1,2,3) THEN 'Q1'
      WHEN MONTH(InvoiceDate) IN (4,5,6) THEN 'Q2'
      WHEN MONTH(InvoiceDate) IN (7,8,9) THEN 'Q3'
      WHEN MONTH(InvoiceDate) IN (10,11,12) THEN 'Q4'
    END AS quarter
  FROM view_valid_sales
)
SELECT
  year,
  quarter,
  SUM(revenue) AS quarterly_revenue,
  COUNT(*) AS transaction_count,
  COUNT(DISTINCT Invoice) AS unique_orders,
  AVG(revenue) AS avg_transaction
FROM valid_sales
GROUP BY year, quarter
ORDER BY year, quarter;

-- 4) Data notes: dataset starts on 1st of december 2009 and ends mid-month in Dec 2011
SELECT
  MIN(InvoiceDate) AS min_valid_date,
  MAX(InvoiceDate) AS max_valid_date
FROM view_valid_sales;

-- Inspection to understand why december data should be handle cautiously 
SELECT
  MIN(InvoiceDate) AS dec_2011_first_date,
  MAX(InvoiceDate) AS dec_2011_last_date,
  COUNT(DISTINCT DATE(InvoiceDate)) AS days_present
FROM view_valid_sales
WHERE YEAR(InvoiceDate) = 2011
  AND MONTH(InvoiceDate) = 12;
-- Started 1st of December - 9th December  
