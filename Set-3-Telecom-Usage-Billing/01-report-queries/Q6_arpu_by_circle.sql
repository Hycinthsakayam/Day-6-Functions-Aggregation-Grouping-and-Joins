USE TelecomDB;
GO

-- Q6. ARPU (average revenue per user) by circle for October 2026
SELECT c.circle_name,
       COUNT(DISTINCT i.subscriber_id) AS subscribers,
       SUM(i.amount)                   AS revenue,
       CAST(SUM(i.amount) / COUNT(DISTINCT i.subscriber_id) AS DECIMAL(10,2)) AS arpu
FROM invoices i
JOIN subscribers s ON s.subscriber_id = i.subscriber_id
JOIN circles c     ON c.circle_id = s.circle_id
WHERE i.bill_month = '2026-10-01'
GROUP BY c.circle_name
ORDER BY arpu DESC;
GO
