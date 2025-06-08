USE restaurant;

SELECT * FROM menu_items;

# ********************
# Change Column Name *
# ********************

ALTER TABLE menu_items
RENAME COLUMN ï»¿menu_item_id TO menu_item_id;
COMMIT;

ALTER TABLE order_details
RENAME COLUMN ï»¿order_details_id TO menu_item_id;
COMMIT;

# ******************
# Check Null Value *
# ******************

SELECT * FROM order_details
WHERE (order_id IS NULL) OR (order_date IS NULL) OR (order_time IS NULL) OR (item_id IS NULL);

SELECT * FROM menu_items
WHERE (menu_item_id IS NULL) OR (item_name IS NULL) OR (category IS NULL) OR (price IS NULL);

# *********************
# Remove Null Values  *
# *********************

START TRANSACTION;
	DELETE FROM order_details
	WHERE (order_id IS NULL) OR (order_date IS NULL) OR (order_time IS NULL) OR (item_id IS NULL);
COMMIT;

# ***********************
# Check Duplicate Value *
# ***********************

WITH duplicated AS (
	SELECT *,
		RANK() OVER(PARTITION BY 
        menu_item_id, item_name, category, price) AS row_num
	FROM menu_items
)
SELECT * FROM duplicated
WHERE row_num > 2;


WITH duplicated AS (
	SELECT *,
		ROW_NUMBER() OVER(PARTITION BY 
				menu_item_id, order_id, order_date, order_time, item_id  ) AS row_num
	FROM order_details
)
SELECT * FROM duplicated
WHERE row_num > 2;

SELECT * FROM menu_items;
SELECT * FROM order_details;


# *********************************************************************************************************
# Objective 1 : Exploring The itenms Table	
#
# 1. To find the number of items on the menu.
# 2. What are the least and Most expensive Items on the menu?
# 3. How many italian disher are on the menu? What are the least and most expensive dishes on the menu?
# 4. How many Dishers are in each category? What is the average disher price within each category?
# 5. Top 10 menu items based on the number of orders and total revenue.
#
# ********************************************************************************************************* 

# 1. The number of items on the menu.
SELECT COUNT(DISTINCT item_name) AS num_of_items
FROM menu_items;

# 2. What are the least and Most expensive Items on the menu?
WITH priceRank AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY price) AS row_num
  FROM menu_items
),
maxRow AS (
  SELECT MAX(row_num) AS max_row FROM priceRank
)
SELECT menu_item_id, item_name, category, price, row_num AS least_most
FROM priceRank
JOIN maxRow
ON priceRank.row_num = 1 OR priceRank.row_num = maxRow.max_row;

# 3. How many italian disher are on the menu? What are the least and most expensive dishes on the menu?
WITH priceRank AS (
  SELECT *, ROW_NUMBER() OVER (ORDER BY price) AS row_num
  FROM menu_items
  WHERE category = "Italian"
),
maxRow AS (
  SELECT MAX(row_num) AS max_row FROM priceRank
)
SELECT item_name, category, price, maxRow.max_row AS total_dishes
FROM priceRank
JOIN maxRow
ON priceRank.row_num = 1 OR priceRank.row_num = maxRow.max_row;

# 4. How many Dishers are in each category? What is the average disher price within each category?
SELECT category, COUNT(DISTINCT item_name) AS num_of_dishes, ROUND(AVG(price), 2) AS avg_price
FROM menu_items
GROUP BY category;

# ********************************************************************************************************
# Objective 2 : Exploring The Order Table	
#
# 1. What is the Date range of the table?
# 2. How many orders were made within this date range?
# 3. How many items were ordered within this date range?
# 4. Which order had most number of items?
# 5. How many orders had more than 12 items? 
#
# *********************************************************************************************************

SELECT * FROM order_details
LIMIT 30;

# 1. What is the Date range of the table?
SELECT MIN(order_date), MAX(order_date)
FROM order_details;

# 2. How many orders were made within this date range?

SELECT COUNT( DISTINCT order_id) AS total_orders
FROM order_details
WHERE order_date  BETWEEN '1/1/23' AND '3/9/23';

# 3. How many items were ordered within this date range?

SELECT COUNT(item_id) AS total_orders
FROM order_details
WHERE order_date  BETWEEN '1/1/23' AND '3/9/23';

# 4. Which order had most number of items?
SELECT order_id, COUNT(item_id) AS num_of_items
FROM order_details
GROUP BY order_id
ORDER BY num_of_items DESC;

# 5. How many orders had more than 12 items?
WITH numItem AS (
	SELECT order_id, COUNT(item_id) AS num_of_item
	FROM order_details
		GROUP BY order_id
		HAVING num_of_item > 12
)
SELECT count(*)
FROM numItem;

# ********************************************************************************************************
# Objective 3 : Analyze Customer Behavior	
# 1. Combine the two table
# 2. what were the least and most ordered_items? what categories were they in?
# 3. What were the top 5 orders that spent the most money?
# 4. what insight can we gather from the details of the highest spend order?
# 5. what insight can we gather from the top 5 highest spend orders?
# 6. Top 10 menu items based on the number of orders and total revenue.
# *********************************************************************************************************

# 1. Combine the two table.
CREATE TABLE IF NOT EXISTS order_menu_join AS
SELECT md.menu_item_id, od.order_id, od.order_date, od.order_time, od.item_id, md.item_name, md.category, md.price
FROM order_details AS od
	LEFT JOIN menu_items AS md
    ON od.item_id = md.menu_item_id;
    
    
SELECT * FROM order_menu_join;
    
# 2. what were the least and most ordered_items? what categories were they in?
SELECT item_name,category,  COUNT(item_id) AS itemOrdered
FROM order_menu_join 
GROUP BY item_name, category
ORDER BY itemOrdered DESC;

# 3. Top 5 performing categories 
SELECT category, SUM(order_id) AS total_order, ROUND(SUM(price), 2) AS total_revenue
FROM order_menu_join
GROUP BY category
ORDER BY total_revenue DESC;

# 4. What were the top 5 orders that spent the most money?
SELECT order_id, ROUND(SUM(price), 2) AS total_Spent
FROM order_menu_join
GROUP BY order_id
ORDER BY total_Spent DESC 
LIMIT 5;

# 5. what insight can we gather from the details of the highest spend order?
SELECT category, COUNT(category) catOrderRank FROM order_menu_join
WHERE order_id = '440'
GROUP BY category
ORDER BY catOrderRank DESC;

# 6. what insight can we gather from the top 5 highest spend orders?
SELECT category, count(category) AS catOrderRank
FROM order_menu_join 
WHERE order_id IN('440','2075'	'1957',	'330','2675')
GROUP BY category;

SELECT order_id, item_name, count(item_name) AS itemOrderRank
FROM order_menu_join 
WHERE order_id IN('440','2075'	'1957',	'330','2675')
GROUP BY item_name, order_id;

# 7. In which month has the highest order and which category had the higest sell during that month?
WITH monthPrice AS (
	SELECT MONTHNAME(DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%y'), '%e/%c/%y')) AS monthName, price 
	FROM order_menu_join
)
SELECT monthName, ROUND(SUM(price), 2) as total
FROM monthPrice
GROUP BY monthName;

WITH monthPrice AS (
	SELECT MONTHNAME(DATE_FORMAT(STR_TO_DATE(order_date, '%m/%d/%y'), '%e/%c/%y')) AS monthName, price, category
	FROM order_menu_join
) 
SELECT category, ROUND(SUM(price), 2) as total
FROM monthPrice
WHERE monthPrice.monthName = "March"
GROUP BY category
ORDER BY total DESC;

# In this dataset, the date ranges from January to March
# March had highest sell with 54610.6 dollars, during this month Italian food had the higest sell.

# 8.  Identify peak days 
SELECT 
  DAYNAME(STR_TO_DATE(order_date, '%m/%d/%y')) AS day_name,
  COUNT(order_id) AS total_orders,
  ROUND(SUM(price), 2) AS total_revenue
FROM order_menu_join
GROUP BY day_name
ORDER BY total_revenue DESC; 

# 9.  Identify peak Hours 

ALTER TABLE order_menu_join
ADD newFormatDate varchar(255);

START TRANSACTION;
UPDATE order_menu_join
SET newFormatDate = DATE_FORMAT(STR_TO_DATE(order_time, '%r'), '%H:%i:%s');
COMMIT;

SELECT 
  HOUR(newFormatDate) AS time, 
  COUNT(newFormatDate) AS total_orders,  
  ROUND(SUM(price), 2) AS total_revenue  
FROM order_menu_join
GROUP BY time  
ORDER BY time;  

# 5. Top 10 menu items based on the number of orders and total revenue.

SELECT item_name, COUNT(order_id) AS total_orders, ROUND(SUM(price), 2) AS total_revenue
FROM order_menu_join
GROUP BY item_name
ORDER BY total_revenue DESC
LIMIT 10;