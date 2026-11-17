USE RetailSalesDB;
GO

-- Q3. Customers with more than three orders
SELECT c.customer_id, c.full_name, c.city, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.full_name, c.city
HAVING COUNT(o.order_id) > 3
ORDER BY total_orders DESC;
GO
