# Supply-chain-analysis
Supply Chain Analytics Project (SQL Server + Power BI)
🚀 Project Overview

This project focuses on analyzing end-to-end Supply Chain performance using three core datasets:

Product Data – product details, category, pricing
Inventory Data – stock levels, reorder points, warehouse stock
Sales Data – order transactions and quantity sold

Using SQL Server for data modeling and transformation and Power BI for visualization, this project transforms raw operational data into actionable business insights.

The goal is to simulate real-world supply chain decision-making such as:

Stock optimization
Demand forecasting signals
Revenue contribution analysis
Inventory risk detection
🧠 Business Problem Statement

In a retail supply chain, companies often face:

Stockouts → lost sales and customer dissatisfaction
Overstocking → increased holding costs
Poor visibility into demand vs inventory
Lack of product-level revenue intelligence

This project solves these challenges by building a data-driven decision system.

🗂️ Data Model
Tables Used:
product_data (product_id, product_name, category, price)
inventory_data (product_id, stock_level, reorder_point, warehouse)
sales_data (product_id, order_date, quantity_sold, revenue)
Relationship:

All tables are connected using product_id (Primary Key / Foreign Key relationship)

📊 Key Business Insights
1️⃣ Stock Reorder Analysis (Low Stock Detection)

Identifies products where stock falls below reorder level:

📌 Business Impact:

Prevents stockouts
Ensures continuous product availability
Supports automatic replenishment decisions

💡 Insight Example:

Products flagged as “Low Stock” require urgent replenishment
Helps procurement teams act before demand loss occurs
2️⃣ Top Selling Products

Identifies products with highest total quantity sold.

📌 Business Impact:

Highlights fast-moving inventory
Helps prioritize production and procurement
Supports marketing focus on high-demand products

💡 Insight Example:

Small % of products generate majority of sales (Pareto principle)
3️⃣ Revenue Contribution by Product

Calculates total revenue generated per product.

📌 Business Impact:

Identifies high-value products
Supports pricing strategy decisions
Helps optimize product portfolio

💡 Insight Example:

Some products may sell less but generate high revenue (premium SKUs)
4️⃣ Demand vs Stock Analysis

Compares:

Total sales demand (quantity sold)
Current stock levels

📌 Business Impact:

Identifies supply-demand imbalance
Supports inventory planning
Prevents both shortages and overstocking

💡 Insight Example:

High demand + low stock = urgent replenishment needed
Low demand + high stock = overstock risk
5️⃣ Overstocked vs Understocked Products

Classification logic:

Understocked: stock < demand trend
Overstocked: stock >> demand trend

📌 Business Impact:

Reduces holding cost
Improves warehouse efficiency
Optimizes cash flow

💡 Insight Example:

Overstocked items should be discounted or bundled
Understocked items need priority procurement
6️⃣ Revenue Leaders (Top Revenue Generating Products)

Ranks products based on total revenue contribution.

📌 Business Impact:

Helps identify “profit drivers”
Supports strategic product focus
Guides expansion decisions

💡 Insight Example:

A small number of products may contribute majority of revenue (80/20 rule)
📈 Power BI Dashboard Features

The dashboard includes:

KPI Cards:
Total Sales
Total Revenue
Total Products
Stock Health Status
Visuals:
Top Products by Revenue
Sales vs Stock Comparison Chart
Inventory Status (Overstock / Understock)
Category-wise performance
Filters:
Product Category
Warehouse
Time (Order Date)
🛠️ Tools & Technologies
SQL Server (Data Cleaning & Joins)
Power BI (Dashboard & Visualization)
DAX (Measures & KPIs)
Data Modeling (Star Schema approach)
