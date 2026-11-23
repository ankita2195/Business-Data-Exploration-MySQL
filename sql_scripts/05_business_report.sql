-- Generating a report that shows all the key metrics of the business

SELECT 
    'Total Sales' measure_name, SUM(sales_amount) value
FROM
    gold_fact_sales 
UNION ALL SELECT 
    'Total Quantity' measure_name, SUM(quantity) value
FROM
    gold_fact_sales 
UNION ALL SELECT 
    'Average Selling Price' measure_name,
    ROUND(AVG(price)) value
FROM
    gold_fact_sales 
UNION ALL SELECT 
    'Total Profit' measure_name,
    SUM(sales_amount) - SUM(cost * quantity) value
FROM
    gold_fact_sales s
        JOIN
    gold_dim_products p ON p.product_key = s.product_key 
UNION ALL SELECT 
    'Profit Margin' measure_name,
    CONCAT(ROUND(100.0 * (SUM(sales_amount) - SUM(cost * quantity)) / NULLIF(SUM(sales_amount), 0),
                    2),
            '%') value
FROM
    gold_fact_sales s
        JOIN
    gold_dim_products p ON p.product_key = s.product_key 
UNION ALL SELECT 
    'Total Customers' measure_name, COUNT(customer_id) value
FROM
    gold_dim_customers 
UNION ALL SELECT 
    'Total Products' measure_name, COUNT(product_id) value
FROM
    gold_dim_products 
UNION ALL SELECT 
    'Total Orders' measure_name,
    COUNT(DISTINCT order_number) value
FROM
    gold_fact_sales;
