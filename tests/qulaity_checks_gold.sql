/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs quality checks to validate the integrity, consistency,
    and accuracy of the Gold Layer. 
    These checks ensures:
      - Referential Integrity
      - Uniqueness of surrogate keys in dimension tables.
      - Validation or relationships in the data model for analytical purposes.

Usage Notes:
    - Run these checks after data loading the Silver Layer
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/

-- ============================================================================
-- Checking 'gold.dim_customers'
-- ============================================================================
-- Checking for Uniqueness of Customer Key in gold.dim_customers Table
-- Expectation: No results
SELECT 
    customer_key,
    COUNT(*) as duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ============================================================================
-- Checking 'gold.product_key
-- ============================================================================
-- Checking for Uniqueness of Product Key in gold.dim_product Table
-- Expectation: No results
SELECT 
    product_key,
    COUNT(*) as duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ============================================================================
-- Checking 'gold.fact_sales'
-- ============================================================================
-- Checking the data model connectivity between fact and dimesions
SELECT *
FROM gold.fact_sales AS f
LEFT JOIN gold.dim_customers AS c ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products AS p ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL
