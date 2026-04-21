/* ===========================================================================
PROJECT: Global Electronics Retail - Data Cleaning & ETL Pipeline
AUTHOR: Mher Khachatryan
OBJECTIVE: Transform raw transactional data into a "Single Source of Truth."
KEY ACTIONS: 
  1. Fix Encoding/Import Errors (BOM Removal)
  2. Deduplication using Window Functions
  3. Date Standardization & Casting
  4. Robust Outlier & Null Imputation (Age & Price)
  5. Feature Engineering (Age Segmentation & Revenue Calculation)
===========================================================================
*/

-- PHASE 1: SCHEMA REPAIR
-- Handling UTF-8 BOM encoding issues from the source CSV import
-- ALTER TABLE raw_sales_data 
-- RENAME COLUMN `п»їTransaction_ID` TO Transaction_ID;

-- PHASE 2: DATA CLEANING PIPELINE (Using CTEs for Readability)
WITH DeDuplicatedData AS (
    /* STEP 1: DEDUPLICATION
    Using ROW_NUMBER to identify duplicate Transaction_IDs. 
    This ensures each sale is only counted once in the final dashboard.
    */
    SELECT 
        *,
        ROW_NUMBER() OVER(PARTITION BY Transaction_ID ORDER BY Date) as row_num
    FROM raw_sales_data
),

StandardizedData AS (
    /* STEP 2: TYPE CASTING & TEXT STANDARDIZATION
    Standardizing country names and product categories to prevent 
    duplicated categories in visualization (e.g., 'usa' vs 'USA').
    */
    SELECT 
        Transaction_ID,
        -- Ensuring Date is in a proper format for time-series analysis
        COALESCE(CAST(Date AS DATE), Date) AS Clean_Date, 
        UPPER(TRIM(Country)) AS Country_Fixed,
        CASE 
            WHEN TRIM(LOWER(Product_Category)) IN ('elec.', '  electronics  ', 'electronics') THEN 'Electronics'
            ELSE TRIM(Product_Category)
        END AS Category_Fixed,
        CAST(Customer_Age AS DECIMAL) AS Customer_Age,
        Unit_Price,
        Quantity,
        Rating
    FROM DeDuplicatedData
    WHERE row_num = 1 -- Filtering out the duplicate rows identified in Step 1
),

CleanedData AS (
    /* STEP 3: OUTLIER HANDLING & NULL IMPUTATION
    Using Window Functions to calculate global averages for missing data,
    ensuring '0' or 'NULL' values do not skew demographic reports.
    */
    SELECT 
        *,
        -- Replacing negative/zero prices with the dataset average
        CASE 
            WHEN Unit_Price <= 0 THEN AVG(Unit_Price) OVER() 
            ELSE Unit_Price 
        END AS Price_Fixed,
        
        -- Defaulting missing quantities to 1 to preserve transaction record
        COALESCE(Quantity, 1) AS Qty_Fixed,
        
        -- Age Imputation: Replacing 0 or NULL with the average of valid entries
        CASE 
            WHEN Customer_Age IS NULL OR Customer_Age = 0 THEN 
                (SELECT ROUND(AVG(Customer_Age), 0) FROM StandardizedData WHERE Customer_Age > 0)
            ELSE Customer_Age 
        END AS Age_Fixed
    FROM StandardizedData
)

-- PHASE 3: FINAL TRANSFORMATION & FEATURE ENGINEERING
/* This final step prepares the data for the BI layer (Power BI/Tableau)
by rounding values and creating 'Age Segments' for marketing insights.
*/
SELECT 
    Transaction_ID,
    Clean_Date,
    Country_Fixed AS Country,
    Category_Fixed AS Category,
    Age_Fixed AS Customer_Age,
    ROUND(Price_Fixed, 2) AS Unit_Price,
    Qty_Fixed AS Quantity,
    ROUND(Price_Fixed * Qty_Fixed, 2) AS Total_Revenue, -- Calculated Metric
    -- Creating buckets for demographic analysis
    CASE 
        WHEN Age_Fixed < 25 THEN 'Gen Z'
        WHEN Age_Fixed BETWEEN 25 AND 40 THEN 'Millennial'
        WHEN Age_Fixed BETWEEN 41 AND 60 THEN 'Gen X'
        ELSE 'Senior'
    END AS Age_Segment,
    Rating
FROM CleanedData
ORDER BY Clean_Date DESC;