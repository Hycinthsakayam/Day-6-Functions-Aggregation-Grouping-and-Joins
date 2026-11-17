USE RetailSalesDB;
GO

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
