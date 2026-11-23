-- Dimensions Exploration

SELECT 
    COUNT(DISTINCT customer_id) total_customers
FROM
    gold_dim_customers;
-- 18484 customers

SELECT 
    gender,
    COUNT(DISTINCT customer_id) count,
    CONCAT(ROUND(COUNT(gender) / (SELECT 
                            COUNT(DISTINCT customer_id)
                        FROM
                            gold_dim_customers) * 100,
                    2),
            '%') gender_distribution
FROM
    gold_dim_customers
GROUP BY 1;
-- Gender neutral customer base with slightly high males than females (51% vs 49%)


SELECT 
    country, COUNT(DISTINCT customer_id) count
FROM
    gold_dim_customers
GROUP BY 1
ORDER BY 2 DESC;
-- Highest number of customers come from United States and Australia.

SELECT 
    marital_status, COUNT(DISTINCT customer_id) count
FROM
    gold_dim_customers
GROUP BY 1;
-- Married customers form the majority of the customer base, accounting for roughly 54% compared to 46% single customers.

SELECT 
    COUNT(DISTINCT product_id) total_products
FROM
    gold_dim_products;
-- 295 products

SELECT 
    category,
    COUNT(DISTINCT subcategory) subcategory_count,
    COUNT(product_id) products_count
FROM
    gold_dim_products
GROUP BY 1
ORDER BY 3 DESC;
-- Products are broadly divided into 4 categories: Bikes, Components, Clothing, Accessories; components having the highest number of products.

SELECT 
    product_line, COUNT(DISTINCT category) category_count
FROM
    gold_dim_products
GROUP BY 1
ORDER BY 2 DESC;

-- Date Exploration
SELECT 
    MIN(start_date) min, MAX(start_date) max
FROM
    gold_dim_products;

SELECT 
    MIN(create_date) min, MAX(create_date) max
FROM
    gold_dim_customers;

SELECT 
    MIN(order_date) first_order,
    MAX(order_date) last_order,
    YEAR(MAX(order_date)) - YEAR(MIN(order_date)) order_year_range
FROM
    gold_fact_sales;
-- The data is for 4 years from dec-2010 to jan 2014.

SELECT 
    MIN(birthdate) oldest_birthdate,
    YEAR(CURDATE()) - YEAR(MIN(birthdate)) oldest_cust,
    MAX(birthdate) youngest_birthdate,
    YEAR(CURDATE()) - YEAR(MAX(birthdate)) youngest_cust
FROM
    gold_dim_customers; 

