USE RetailSalesDB;
GO

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
