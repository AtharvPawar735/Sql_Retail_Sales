# Retail Sales Data Analysis using SQL 🛒

## 📌 Project Overview
This project involves a comprehensive exploratory data analysis (EDA) of a retail sales dataset using **MySQL**. The primary objective was to clean the raw data, handle inconsistencies, and extract actionable business insights regarding sales trends, customer behavior, and product performance. 

This repository demonstrates practical proficiency in SQL data manipulation, aggregation, and extracting business value from raw datasets.

## 🛠️ Tech Stack
* **Database Management System:** MySQL
* **Tools Used:** MySQL Workbench / Command Line
* **Techniques:** Data Cleaning, Aggregations, Date/Time Functions, Calculated Columns

## 🗄️ Database Setup & Schema
The analysis revolves around a primary `retail_sales` table.

| Column Name      | Data Type | Description |
|------------------|-----------|-------------|
| `transaction_id` | INT       | Unique identifier for each sale |
| `sale_date`      | DATE      | Date the transaction occurred |
| `sale_time`      | TIME      | Time the transaction occurred |
| `gender`         | VARCHAR   | Customer demographic (Male/Female) |
| `category`       | VARCHAR   | Product category (e.g., Electronics, Clothing) |
| `quantity`       | INT       | Number of items purchased in the transaction |
| `cogs`           | FLOAT     | Cost of Goods Sold |
| `total_sale`     | FLOAT     | Total revenue generated from the transaction |

## 🧹 Data Cleaning & Preparation
Before conducting the analysis, I ensured the dataset's integrity by removing incomplete records. The following query was executed to filter out any rows containing `NULL` values across critical columns:

```sql
-- Temporarily disabled safe updates to clean the raw data
SET SQL_SAFE_UPDATES = 0;

DELETE FROM retail_sales
WHERE 
    transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

SET SQL_SAFE_UPDATES = 1;

1. What is the total revenue and total number of orders for each product category?
SELECT 
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_month, 
    SUM(total_sale) AS monthly_revenue
FROM retail_sales
GROUP BY sale_month
ORDER BY sale_month ASC;

2. What is the profitability of each category?
SELECT 
    category, 
    SUM(total_sale) AS total_revenue, 
    SUM(cogs) AS total_cost, 
    SUM(total_sale - cogs) AS total_profit
FROM retail_sales
GROUP BY category
ORDER BY total_profit DESC;
