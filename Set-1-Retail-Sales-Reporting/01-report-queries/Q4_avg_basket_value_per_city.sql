USE RetailSalesDB;
GO

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
