CREATE DATABASE sql_project_p1;
USE sql_project_p1;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
            
SELECT COUNT(*) FROM retail_sales;

SELECT* FROM retail_sales;

#Data Cleaning

SELECT * FROM retail_sales
WHERE quantity IS NULL;
SELECT * FROM retail_sales
WHERE transaction_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;
    
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
    
    
#Data Exploration

#how many customers we have
SELECT COUNT(DISTINCT customer_id) as total_sales from retail_sales;

#Q1 retrive all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date='2022-11-05';

#Q2 retrieve all transactions where the category is 'clothing' and quantity sold is more than 10 in month of Nov-2022

SELECT * FROM retail_sales WHERE category='Clothing' AND quantity>5 AND year(sale_date)='2022';

#Q3 calculaate the total sales for each category

SELECT 
	category,
	SUM(total_sale) as net_sale,
	COUNT(*) as total_orders
FROM retail_sales
GROUP BY category;

#Q4 find the average age of customers who purchased items from the 'Beauty' category

SELECT AVG(age)
FROM retail_sales
WHERE category='Beauty';

#Q5 total number of transactions made by each gender in each category

SELECT category,gender,COUNT(*) as total_trans
from retail_sales
GROUP BY category,gender;

#Q6 calculate the average sales for each month.find out the best selling month in each year

 

#Q7 CREATE EACH SHIFT AND NUMBER OF ORDERS(EG-MORNING<=12,AFTERNOON BETWEEN 12 & 17 AND EVENING>17)

WITH HOURLY_SALES AS(
SELECT *,
	CASE
		WHEN HOUR(sale_time) <=12 THEN 'MORNING'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
        'EVENING'
	END AS SHIFT
FROM retail_sales
)
SELECT 
	SHIFT,
    COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALES
GROUP BY SHIFT;




