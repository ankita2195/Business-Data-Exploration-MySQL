-- Data Validation

-- Check for duplicate customer keys
SELECT customer_key, COUNT(*)
FROM gold_dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check for missing customer information
SELECT COUNT(*)
FROM gold_dim_customers
WHERE customer_id IS NULL
   OR first_name IS NULL
   OR last_name IS NULL;
   
-- Check for duplicate Product Keys
SELECT product_key, COUNT(*)
FROM gold_dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check for invalid sales values
SELECT *
FROM gold_fact_sales
WHERE sales_amount < 0
   OR quantity <= 0
   OR price < 0;
   
-- Check for customers missing from gold_fact_sales
SELECT DISTINCT customer_key
FROM gold_fact_sales
WHERE customer_key NOT IN (
    SELECT customer_key FROM gold_dim_customers
);

-- Check for products missing from gold_fact_sales
SELECT DISTINCT product_key
FROM gold_fact_sales
WHERE product_key NOT IN (
    SELECT product_key FROM gold_dim_products
);
   
-- No invalid or null values were found.
