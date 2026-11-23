-- Magnitude Analysis

SELECT 
    category,
    COUNT(DISTINCT product_id) product_count,
    SUM(sales_amount) sales
FROM
    gold_fact_sales s
        RIGHT JOIN
    gold_dim_products p ON p.product_key = s.product_key
GROUP BY category
ORDER BY sales DESC;
-- Bikes contribute to around 96% of sales, no sales from the components category

SELECT 
    product_name, SUM(sales_amount) sales
FROM
    gold_fact_sales s
        RIGHT JOIN
    gold_dim_products p ON p.product_key = s.product_key
WHERE
    category = 'Bikes'
GROUP BY product_name
ORDER BY sales DESC;

SELECT 
    category highest_ordered_category, SUM(quantity) qty
FROM
    gold_fact_sales s
        RIGHT JOIN
    gold_dim_products p ON p.product_key = s.product_key
GROUP BY category
ORDER BY qty DESC;

SELECT 
    country,
    SUM(sales_amount) sales,
    COUNT(DISTINCT s.customer_key) customer_count
FROM
    gold_fact_sales s
        RIGHT JOIN
    gold_dim_customers c ON c.customer_key = s.customer_key
GROUP BY country
ORDER BY sales DESC;
-- More than 50% of sales is from US and Australia

SELECT 
    category,
    ROUND(AVG(cost)) avg_cost,
    ROUND(AVG(price)) avg_price
FROM
    gold_fact_sales s
        RIGHT JOIN
    gold_dim_products p ON p.product_key = s.product_key
GROUP BY category
ORDER BY avg_cost DESC;

SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) name,
    COUNT(DISTINCT order_number) orders,
    SUM(sales_amount) sales
FROM
    gold_fact_sales s
        RIGHT JOIN
    gold_dim_customers c ON c.customer_key = s.customer_key
GROUP BY customer_id , name
ORDER BY sales DESC;

SELECT 
    gender, COUNT(customer_id) count
FROM
    gold_dim_customers
GROUP BY gender;

SELECT 
    category, COUNT(product_id) count
FROM
    gold_dim_products
GROUP BY category;
