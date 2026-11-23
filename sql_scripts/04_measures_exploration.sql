-- Measures Exploration

SELECT 
    SUM(sales_amount) total_sales
FROM
    gold_fact_sales;
-- Total sales is approx 300,00,000

SELECT 
    SUM(quantity) total_quantity
FROM
    gold_fact_sales;
-- Total quantity sold = 60423

SELECT 
    AVG(price) average_SP
FROM
    gold_fact_sales;
-- Average selling price is around 486

SELECT 
    COUNT(DISTINCT customer_id) total_customers
FROM
    gold_dim_customers;
-- There are around 18K customers in total.

SELECT 
    COUNT(DISTINCT product_id) total_products
FROM
    gold_dim_products;
-- 295 products.

SELECT 
    COUNT(DISTINCT order_number) total_orders
FROM
    gold_fact_sales;
-- 27695 orders 

SELECT 
    COUNT(DISTINCT customer_key) total_customers
FROM
    gold_dim_customers
WHERE
    customer_key IN (SELECT 
            customer_key
        FROM
            gold_fact_sales);
-- All the listed customers have placed an order atleast once.

SELECT 
    (SUM(sales_amount) - SUM(cost * quantity)) total_profit,
    CONCAT(ROUND(100 * ((SUM(sales_amount) - SUM(cost * quantity)) / SUM(cost * quantity)),
                    2),
            '%') 'profit%'
FROM
    gold_fact_sales s
        JOIN
    gold_dim_products p ON p.product_key = s.product_key;
-- Total profit made was around 12 millions and profit percentage was 66%.

