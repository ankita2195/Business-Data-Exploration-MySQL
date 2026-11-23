-- Drop and recreate the database
DROP DATABASE IF EXISTS DataWarehouseAnalytics;

CREATE DATABASE DataWarehouseAnalytics;

USE DataWarehouseAnalytics;

-- Create Tables

CREATE TABLE gold_dim_customers (
    customer_key INT,
    customer_id INT,
    customer_number VARCHAR(50),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    country VARCHAR(50),
    marital_status VARCHAR(50),
    gender VARCHAR(50),
    birthdate DATE,
    create_date DATE
);

CREATE TABLE gold_dim_products (
    product_key INT,
    product_id INT,
    product_number VARCHAR(50),
    product_name VARCHAR(50),
    category_id VARCHAR(50),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    maintenance VARCHAR(50),
    cost INT,
    product_line VARCHAR(50),
    start_date DATE
);

CREATE TABLE gold_fact_sales (
    order_number VARCHAR(50),
    product_key INT,
    customer_key INT,
    order_date DATE,
    shipping_date DATE,
    due_date DATE,
    sales_amount INT,
    quantity TINYINT,
    price INT
);

-- Load Data

TRUNCATE TABLE gold_dim_customers;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dim_customers.csv'
INTO TABLE gold_dim_customers
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(    customer_key,
    customer_id,
    customer_number,
    first_name,
    last_name,
    country,
    marital_status,
    gender,
    @birthdate,
    @create_date
)
SET
    birthdate = NULLIF(@birthdate, ''),
    create_date = NULLIF(@create_date, '');

TRUNCATE TABLE gold_dim_products;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/dim_products.csv'
INTO TABLE gold_dim_products
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

TRUNCATE TABLE gold_fact_sales;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/fact_sales.csv'
INTO TABLE gold_fact_sales
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    order_number,
    product_key,
    customer_key,
    @order_date,
    @shipping_date,
    @due_date,
    sales_amount,
    quantity,
    price
)
SET
    order_date = NULLIF(@order_date, ''),
    shipping_date = NULLIF(@shipping_date, ''),
    due_date = NULLIF(@due_date, '');
    
    
-- Creating Star Schema
ALTER TABLE gold_dim_customers
ADD CONSTRAINT pk_dim_customers PRIMARY KEY (customer_key);

ALTER TABLE gold_dim_products
ADD CONSTRAINT pk_dim_products PRIMARY KEY (product_key);

ALTER TABLE gold_fact_sales
ADD CONSTRAINT fk_sales_product
    FOREIGN KEY (product_key)
    REFERENCES gold_dim_products(product_key),
ADD CONSTRAINT fk_sales_customer
    FOREIGN KEY (customer_key)
    REFERENCES gold_dim_customers(customer_key);
