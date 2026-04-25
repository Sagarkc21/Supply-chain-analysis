------ Product Table (Master Data)

CREATE TABLE product_data (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    brand VARCHAR(50),
    unit_price DECIMAL(10,2),
    supplier_name VARCHAR(100),
    is_active BIT
);

------inventory table

CREATE TABLE inventory_data (
    inventory_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT FOREIGN KEY REFERENCES product_data(product_id),
    warehouse_location VARCHAR(100),
    stock_level INT,
    reorder_point INT,
    safety_stock INT,
    last_restock_date DATE,
    storage_cost_per_unit DECIMAL(10,2)
);

----sales table---

CREATE TABLE sales_data (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    product_id INT FOREIGN KEY REFERENCES product_data(product_id),
    order_date DATE,
    quantity_sold INT,
    sale_price DECIMAL(10,2),
    customer_region VARCHAR(50),
    channel VARCHAR(50)  -- online / retail / marketplace
);

-----select all data from table---
select * from product_data;
select * from inventory_data;
select * from sales_data;

-------Data validation---

SELECT * FROM product_data WHERE product_name IS NULL;
SELECT * FROM inventory_data WHERE stock_level IS NULL;
SELECT * FROM sales_data WHERE quantity_sold IS NULL;

--------Broken relationship checked--

SELECT s.*
FROM sales_data s
LEFT JOIN product_data p ON s.product_id = p.product_id
WHERE p.product_id IS NULL;


-------KPIs build---


-----Checking if stocke is less than reorder point.
----The current stock of a product is less than or equal to the minimum level (reorder point) at which we should restock it.

SELECT p.product_name, i.stock_level, i.reorder_point
FROM inventory_data i
JOIN product_data p ON i.product_id = p.product_id
WHERE i.stock_level <= i.reorder_point;


-----Top selling products--

SELECT p.product_name,
       SUM(s.quantity_sold) AS total_sold
FROM sales_data s
JOIN product_data p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;


-----Revenue calucations for each product name---

SELECT p.product_name,
       SUM(s.quantity_sold * s.sale_price) AS revenue
FROM sales_data s
JOIN product_data p ON s.product_id = p.product_id
GROUP BY p.product_name;


----Demand vs Stock analysis-- “Are we selling more than we have in stock?” critical suitaions

SELECT p.product_name,
       i.stock_level,
       SUM(s.quantity_sold) AS total_demand
FROM product_data p
JOIN inventory_data i ON p.product_id = i.product_id
JOIN sales_data s ON p.product_id = s.product_id
GROUP BY p.product_name, i.stock_level;


------Which products are overstocked or understocked?

SELECT 
    p.product_name,
    i.stock_level,
    i.reorder_point,
    CASE 
        WHEN i.stock_level <= i.reorder_point THEN 'Reorder Needed'
        WHEN i.stock_level > i.reorder_point * 3 THEN 'Overstock'
        ELSE 'Healthy'
    END AS stock_status
FROM inventory_data i
JOIN product_data p ON i.product_id = p.product_id;


-------Which Product generate most revenue (Most revenue generate product)

SELECT 
    p.product_name,
    SUM(s.quantity_sold * s.sale_price) AS total_revenue
FROM sales_data s
JOIN product_data p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;


------

SELECT 
    p.product_name,
    SUM(s.quantity_sold) AS total_sold,
    CASE 
        WHEN SUM(s.quantity_sold) > 50 THEN 'Fast Moving'
        WHEN SUM(s.quantity_sold) BETWEEN 20 AND 50 THEN 'Medium'
        ELSE 'Slow Moving'
    END AS movement_type
FROM sales_data s
JOIN product_data p ON s.product_id = p.product_id
GROUP BY p.product_name;


---Which product required immediate restocking( Checking stock level)

SELECT 
    p.product_name,
    i.stock_level,
    i.reorder_point
FROM inventory_data i
JOIN product_data p ON i.product_id = p.product_id
WHERE i.stock_level <= i.reorder_point;


---Total sales per suppliers


SELECT 
    p.supplier_name,
    SUM(s.quantity_sold) AS total_sales
FROM sales_data s
JOIN product_data p 
    ON s.product_id = p.product_id
GROUP BY 
    p.supplier_name
ORDER BY 
    total_sales DESC;
