USE RetailSalesDB;
GO

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
