-- ============================================
-- 03_customers_and_product_seasonality.sql
-- Purpose:
-- 1) New vs returning customers by quarter
-- 2) Q4 vs non-Q4 product mix shift
-- ============================================

USE online_retail;

-- 1) Customer evolution: new vs returning customers (by quarter)
WITH customer_first_purchase AS (
  SELECT
    CustomerID,
    MIN(InvoiceDate) AS first_purchase_date,
    YEAR(MIN(InvoiceDate)) AS first_year,
    QUARTER(MIN(InvoiceDate)) AS first_quarter
  FROM view_valid_sales
  WHERE CustomerID IS NOT NULL AND CustomerID <> ''
  GROUP BY CustomerID
),
quarterly_customers AS (
  SELECT
    YEAR(v.InvoiceDate) AS year,
    QUARTER(v.InvoiceDate) AS quarter_num,
    COUNT(DISTINCT v.CustomerID) AS total_customers,
    COUNT(DISTINCT CASE
      WHEN YEAR(v.InvoiceDate) = f.first_year
       AND QUARTER(v.InvoiceDate) = f.first_quarter
      THEN v.CustomerID END) AS new_customers,
    COUNT(DISTINCT CASE
      WHEN YEAR(v.InvoiceDate) > f.first_year
        OR (YEAR(v.InvoiceDate) = f.first_year AND QUARTER(v.InvoiceDate) > f.first_quarter)
      THEN v.CustomerID END) AS returning_customers
  FROM view_valid_sales v
  JOIN customer_first_purchase f
    ON v.CustomerID = f.CustomerID
  WHERE v.CustomerID IS NOT NULL AND v.CustomerID <> ''
  GROUP BY YEAR(v.InvoiceDate), QUARTER(v.InvoiceDate)
)
SELECT
  year,
  CONCAT('Q', quarter_num) AS quarter,
  total_customers,
  new_customers,
  returning_customers,
  ROUND(new_customers * 100.0 / NULLIF(total_customers, 0), 2) AS pct_new_customers,
  ROUND(returning_customers * 100.0 / NULLIF(total_customers, 0), 2) AS pct_returning_customers
FROM quarterly_customers
ORDER BY year, quarter_num;

-- 2) Product seasonality: Q4 vs non-Q4 revenue comparison
WITH sales_tagged AS (
  SELECT
    StockCode,
    Description,
    revenue,
    CASE WHEN MONTH(InvoiceDate) IN (10,11,12) THEN 1 ELSE 0 END AS is_q4
  FROM view_valid_sales
),
product_revenue AS (
  SELECT
    StockCode,
    Description,
    SUM(CASE WHEN is_q4 = 1 THEN revenue ELSE 0 END) AS q4_revenue,
    SUM(CASE WHEN is_q4 = 0 THEN revenue ELSE 0 END) AS non_q4_revenue,
    SUM(revenue) AS total_revenue
  FROM sales_tagged
  GROUP BY StockCode, Description
),
ranked_product AS (
  SELECT
    StockCode,
    Description,
    q4_revenue,
    non_q4_revenue,
    total_revenue,
    ROW_NUMBER() OVER (ORDER BY q4_revenue DESC) AS q4_rank,
    ROW_NUMBER() OVER (ORDER BY non_q4_revenue DESC) AS non_q4_rank,
    ROUND(100.0 * q4_revenue / NULLIF(total_revenue, 0), 1) AS q4_pct
  FROM product_revenue
)
SELECT
  StockCode,
  LEFT(Description, 40) AS Description,
  q4_revenue,
  non_q4_revenue,
  total_revenue,
  q4_rank,
  non_q4_rank,
  q4_pct,
  CASE
    WHEN q4_rank <= 20 AND non_q4_rank <= 20 THEN 'TOP IN BOTH'
    WHEN q4_rank <= 20 THEN 'Q4 STAR'
    WHEN non_q4_rank <= 20 THEN 'YEAR-ROUND'
    ELSE NULL
  END AS performance_tag
FROM ranked_product
WHERE q4_rank <= 20 OR non_q4_rank <= 20
ORDER BY
  CASE WHEN q4_rank <= 20 AND non_q4_rank <= 20 THEN 1 ELSE 2 END,
  q4_rank;
