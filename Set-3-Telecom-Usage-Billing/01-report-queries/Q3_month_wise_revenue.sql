USE TelecomDB;
GO

-- Q3. Month-wise revenue (billed and collected)
SELECT FORMAT(bill_month, 'MMM yyyy') AS bill_month,
       COUNT(*)    AS invoices,
       SUM(amount) AS billed,
       SUM(CASE WHEN paid_on IS NOT NULL THEN amount ELSE 0 END) AS collected
FROM invoices
GROUP BY bill_month
ORDER BY MIN(bill_month);
GO
