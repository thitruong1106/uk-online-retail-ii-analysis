-- ===================================================
-- 00_setup_import 
-- Purpose: Create table and import Online Retail II CSV into MySQL 
-- Notes: Replace 'path_to_your_csv/online_retail_II.csv' with your local file directory. 
-- MySQL will need FILE privileges enable 
-- ===================================================

DROP TABLE IF EXISTS online_retail_ii;

CREATE TABLE online_retail_ii (
  Invoice VARCHAR(20),
  StockCode VARCHAR(20),
  Description VARCHAR(255),
  Quantity INT,
  InvoiceDate DATETIME,
  Price DECIMAL(10,2),
  CustomerID VARCHAR(20),
  Country VARCHAR(100)
);

LOAD DATA INFILE
'path_to_your_csv/online_retail_II.csv'
INTO TABLE online_retail_ii
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Invoice, StockCode, Description, Quantity, @InvoiceDate, Price, CustomerID, Country)
SET InvoiceDate = STR_TO_DATE(@InvoiceDate, '%Y-%m-%d %H:%i:%s');
