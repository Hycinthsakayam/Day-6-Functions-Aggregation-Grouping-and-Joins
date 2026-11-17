USE RetailSalesDB;
GO

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
