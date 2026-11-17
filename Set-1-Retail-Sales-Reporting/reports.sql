-- Day 6 - Set 1 : Retail Sales Reporting
-- reports.sql  (run setup.sql first)
-- revenue = quantity * unit_price of delivered orders (cancelled orders are left out)

USE RetailSalesDB;
GO
-- [shot:q1]
-- Q1. Top 5 products by revenue
SELECT TOP 5 p.product_name, p.category,
       SUM(oi.quantity)                 AS units_sold,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM order_items oi
JOIN orders o   ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status = 'Delivered'
GROUP BY p.product_name, p.category
ORDER BY revenue DESC;
GO
-- [shot:q2]
-- Q2. Month-wise sales
SELECT FORMAT(o.order_date, 'yyyy-MM')  AS sales_month,
       COUNT(DISTINCT o.order_id)        AS orders,
       SUM(oi.quantity * oi.unit_price)  AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY sales_month;
GO
-- [shot:q3]
-- Q3. Customers with more than three orders
SELECT c.customer_id, c.full_name, c.city, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.full_name, c.city
HAVING COUNT(o.order_id) > 3
ORDER BY total_orders DESC;
GO
-- [shot:q4]
-- Q4. Average basket value per city
WITH order_totals AS (
    SELECT o.order_id, c.city, SUM(oi.quantity * oi.unit_price) AS basket_value
    FROM orders o
    JOIN customers c    ON c.customer_id = o.customer_id
    JOIN order_items oi ON oi.order_id = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY o.order_id, c.city
)
SELECT city, COUNT(*) AS orders, CAST(ROUND(AVG(basket_value), 2) AS DECIMAL(10,2)) AS avg_basket_value
FROM order_totals
GROUP BY city
ORDER BY avg_basket_value DESC;
GO
-- [shot:q5]
-- Q5. Orders without payment
SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
JOIN customers c     ON c.customer_id = o.customer_id
LEFT JOIN payments p ON p.order_id = o.order_id
WHERE p.order_id IS NULL
  AND o.status = 'Delivered'
ORDER BY o.order_id;
GO
-- [shot:q6]
-- Q6. Customers with no orders
SELECT c.customer_id, c.full_name, c.city, c.joined_on
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;
GO
-- [shot:q7]
-- Q7. Revenue share of each product category
SELECT p.category,
       SUM(oi.quantity * oi.unit_price) AS revenue,
       CAST(ROUND(SUM(oi.quantity * oi.unit_price) * 100.0
             / SUM(SUM(oi.quantity * oi.unit_price)) OVER (), 2) AS DECIMAL(5,2)) AS share_percent
FROM order_items oi
JOIN orders o   ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status = 'Delivered'
GROUP BY p.category
ORDER BY revenue DESC;
GO
-- [shot:q8]
-- Q8. Day with the highest sales
SELECT TOP 1 o.order_date,
       DATENAME(WEEKDAY, o.order_date)  AS day_name,
       COUNT(DISTINCT o.order_id)       AS orders,
       SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY o.order_date
ORDER BY revenue DESC;
GO
-- [shot:t2]
-- Task 2. Customer-friendly summary using UPPER, CONCAT, DATEDIFF, FORMAT and ROUND
SELECT c.customer_id,
       CONCAT(UPPER(c.full_name), ' (', c.city, ') - customer for ',
              DATEDIFF(MONTH, c.joined_on, GETDATE()), ' months, ',
              COUNT(DISTINCT o.order_id), ' order(s), spent Rs. ',
              FORMAT(ROUND(SUM(oi.quantity * oi.unit_price), 0), 'N0', 'en-IN'),
              ', last order on ', FORMAT(MAX(o.order_date), 'dd MMM yyyy')) AS customer_summary
FROM customers c
JOIN orders o       ON o.customer_id = c.customer_id AND o.status = 'Delivered'
JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.full_name, c.city, c.joined_on
ORDER BY c.customer_id;
GO
-- [shot:t3]
-- Task 3. NULL behaviour : discount is NULL when no coupon was used
SELECT COUNT(*)                 AS count_star,
       COUNT(discount)          AS count_discount,
       SUM(discount)            AS sum_discount,
       AVG(discount)            AS avg_discount,
       AVG(ISNULL(discount, 0)) AS avg_discount_null_as_zero
FROM orders;
GO
