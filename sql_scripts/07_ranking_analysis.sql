-- Ranking Analysis

SELECT 
    product_name, SUM(sales_amount) sales
FROM
    gold_dim_products p
        JOIN
    gold_fact_sales s ON p.product_key = s.product_key
GROUP BY product_name
ORDER BY sales DESC
LIMIT 5;

SELECT 
    product_name, SUM(sales_amount) sales
FROM
    gold_dim_products p
        JOIN
    gold_fact_sales s ON p.product_key = s.product_key
GROUP BY product_name
ORDER BY sales
LIMIT 5;

SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) name,
    SUM(sales_amount) sales
FROM
    gold_dim_customers c
        JOIN
    gold_fact_sales s ON c.customer_key = s.customer_key
GROUP BY 1 , 2
ORDER BY sales DESC
LIMIT 10;

SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) name,
    COUNT(DISTINCT order_number) orders
FROM
    gold_dim_customers c
        JOIN
    gold_fact_sales s ON c.customer_key = s.customer_key
GROUP BY 1 , 2
ORDER BY orders
LIMIT 3;
