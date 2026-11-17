USE RetailSalesDB;
GO

-- Q6. Customers with no orders
SELECT c.customer_id, c.full_name, c.city, c.joined_on
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_id IS NULL;
GO
