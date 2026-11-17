USE TelecomDB;
GO

-- Q4. Invoices overdue by more than 15 days
SELECT i.invoice_id, s.full_name, i.bill_month, i.due_date, i.amount,
       DATEDIFF(DAY, i.due_date, CAST(GETDATE() AS DATE)) AS days_overdue
FROM invoices i
JOIN subscribers s ON s.subscriber_id = i.subscriber_id
WHERE i.paid_on IS NULL
  AND DATEDIFF(DAY, i.due_date, CAST(GETDATE() AS DATE)) > 15
ORDER BY days_overdue DESC;
GO
