USE TelecomDB;
GO

-- Task 2. Formatted invoice number and due-date status
SELECT CONCAT('INV/', c.circle_code, '/', FORMAT(i.bill_month, 'yyyyMM'), '/',
              RIGHT('00000' + CAST(i.invoice_id AS VARCHAR(5)), 5)) AS invoice_no,
       UPPER(s.full_name) AS subscriber,
       CONCAT(LEFT(s.msisdn, 2), 'XXXXX', RIGHT(s.msisdn, 3)) AS mobile,
       FORMAT(i.due_date, 'dd-MMM-yyyy') AS due_date,
       CASE WHEN i.paid_on IS NOT NULL AND i.paid_on > i.due_date THEN 'Paid late'
            WHEN i.paid_on IS NOT NULL THEN 'Paid'
            WHEN DATEDIFF(DAY, i.due_date, GETDATE()) > 15 THEN CONCAT('Overdue ', DATEDIFF(DAY, i.due_date, GETDATE()), ' days')
            WHEN DATEDIFF(DAY, i.due_date, GETDATE()) > 0  THEN 'Overdue'
            ELSE CONCAT('Due in ', DATEDIFF(DAY, GETDATE(), i.due_date), ' days') END AS due_status
FROM invoices i
JOIN subscribers s ON s.subscriber_id = i.subscriber_id
JOIN circles c     ON c.circle_id = s.circle_id
WHERE i.paid_on IS NULL OR i.paid_on > i.due_date OR i.bill_month = '2026-10-01'
ORDER BY i.bill_month, i.invoice_id;
GO
