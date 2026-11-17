USE RetailSalesDB;
GO

-- Q5. Orders without payment
SELECT o.order_id, c.full_name, o.order_date, o.status
FROM orders o
JOIN customers c     ON c.customer_id = o.customer_id
LEFT JOIN payments p ON p.order_id = o.order_id
WHERE p.order_id IS NULL
  AND o.status = 'Delivered'
ORDER BY o.order_id;
GO
