USE RetailSalesDB;
GO

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
