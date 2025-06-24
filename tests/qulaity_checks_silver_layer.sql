/*
=============================================================================
Quality Checks
=============================================================================
Script Purpose:
    This script performs various quality checks for data consitency, accuracy,
    and standardization across the 'silver' schemas. It includes checks for:
    - NULL or duplicate values.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigae and resolve any discrepancies found during the checks.
=============================================================================
*/

--=================================================================
-- Checking 'silver.crm_cust_info'
--===================================================================
-- Checking for NULLS or Duplicates in Primary Key
-- Expectation; No Results
SELECT 
    cst_id,
    COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Checking for Unwanted Spaces
-- Expectations: No Results
SELECT 
    cst_key
FROM silver.crm_cust_info
WHERE cst_key != TRIM(cst_key);

-- Data Standardization & Consistency
SELECT DISTINCT 
    cst_marital_status
FROM silver.crm_cust_info;
  
--=================================================================
-- Checking 'silver.crm_prod_info'
--=================================================================
-- Checking for NULLS or Duplicates in Primary Key
-- Expectation: No Invalid Dates
SELECT 
    prd_id,
    COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Checking for Unwanted Spaces
-- Expectations: No Results
SELECT 
    prd_nm
FROM silver.crm_prd_info
WHERE prd_nm != TRIM(prd_nm);

-- Checking for NULLS or Negative Values In Cost
-- Expectation: No results
SELECT 
    prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL;
  
-- Data Standardization & Consistency 
SELECT DISTINCT
    prd_line
  FROM silver.crm_prd_info;

-- Checking for Invalid Date Orders (Start Date > End Date)
-- Expectation: No Results
SELECT 
    * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

--=================================================================
-- Checking 'silver.crm_sales_detail'
--=================================================================
-- Checking for Invalid Dates
-- Expectation: No Invalid Dates
SELECT 
    NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_detail
WHERE sls_due_dt <= 0
   OR LEN(sls_due_dt) != 8
   OR sls_due_dt > 20300101
   OR sls_due_dt < 19000101;

-- Checking for Invalid Date Orders (Order Dare > Shipping/ Due Dates)
-- Expectation; No Results
SELECT 
    *
FROM silver.crm_sales_detail
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;

-- Checking Data Consistency: Sales = Quanitiy * Price
-- Expectation; No Results
SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM silver.crm_sales_detail
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price;

--=================================================================
-- Checking 'silver.erp_cust_az12'
--=================================================================
-- Identify Out-of-Range Dates
-- Expectation: Birthdates between 1924-01-01 and Today
SELECT DISTINCT
    bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
   OR bdate > GETDATE();

-- Data Standardization & Consitenecy
SELECT DISTINCT
    gen
FROM silver.erp_cust_az12;

--=================================================================
-- Checking 'silver.erp_loc_a101'
--=================================================================
-- Data Standardization & Consitenecy
SELECT DISTINCT
    cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

--=================================================================
-- Checking 'silver.erp_px_cat_g1v2'
--=================================================================
-- Checking for Unwanted Spaces
-- Expectation; No Results
SELECT 
    *
FROM silver.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);

-- Data Standardization & Consistency 
SELECT DISTINCT 
    maintenance
FROM silver.erp_px_cat_g1v2

