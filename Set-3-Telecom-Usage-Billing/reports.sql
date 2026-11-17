-- Day 6 - Set 3 : Telecom Usage and Billing Reporting
-- reports.sql  (run setup.sql first)

USE TelecomDB;
GO
-- [shot:q1]
-- Q1. Total call minutes per plan
SELECT p.plan_name, COUNT(*) AS calls,
       CAST(SUM(cr.duration_sec) / 60.0 AS DECIMAL(10,1)) AS total_minutes
FROM call_records cr
JOIN subscribers s ON s.subscriber_id = cr.subscriber_id
JOIN plans p       ON p.plan_id = s.plan_id
WHERE cr.record_type = 'VOICE'
GROUP BY p.plan_name
ORDER BY total_minutes DESC;
GO
-- [shot:q2]
-- Q2. Subscribers who went over their data limit in October 2026
SELECT s.msisdn, s.full_name, p.plan_name, p.data_limit_gb,
       CAST(SUM(cr.data_mb) / 1024 AS DECIMAL(10,2)) AS used_gb
FROM call_records cr
JOIN subscribers s ON s.subscriber_id = cr.subscriber_id
JOIN plans p       ON p.plan_id = s.plan_id
WHERE cr.record_type = 'DATA'
  AND cr.started_at >= '2026-10-01' AND cr.started_at < '2026-11-01'
GROUP BY s.msisdn, s.full_name, p.plan_name, p.data_limit_gb
HAVING SUM(cr.data_mb) / 1024 > p.data_limit_gb
ORDER BY used_gb DESC;
GO
-- [shot:q3]
-- Q3. Month-wise revenue (billed and collected)
SELECT FORMAT(bill_month, 'MMM yyyy') AS bill_month,
       COUNT(*)    AS invoices,
       SUM(amount) AS billed,
       SUM(CASE WHEN paid_on IS NOT NULL THEN amount ELSE 0 END) AS collected
FROM invoices
GROUP BY bill_month
ORDER BY MIN(bill_month);
GO
-- [shot:q4]
-- Q4. Invoices overdue by more than 15 days
SELECT i.invoice_id, s.full_name, i.bill_month, i.due_date, i.amount,
       DATEDIFF(DAY, i.due_date, CAST(GETDATE() AS DATE)) AS days_overdue
FROM invoices i
JOIN subscribers s ON s.subscriber_id = i.subscriber_id
WHERE i.paid_on IS NULL
  AND DATEDIFF(DAY, i.due_date, CAST(GETDATE() AS DATE)) > 15
ORDER BY days_overdue DESC;
GO
-- [shot:q5]
-- Q5. Subscribers with no usage at all
SELECT s.msisdn, s.full_name, s.activated_on
FROM subscribers s
LEFT JOIN call_records cr ON cr.subscriber_id = s.subscriber_id
WHERE cr.record_id IS NULL;
GO
-- [shot:q6]
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
-- [shot:q7]
-- Q7. Plan popularity
SELECT p.plan_name, p.monthly_fee, COUNT(s.subscriber_id) AS subscribers,
       CAST(COUNT(s.subscriber_id) * 100.0 / (SELECT COUNT(*) FROM subscribers) AS DECIMAL(5,2)) AS share_percent
FROM plans p
LEFT JOIN subscribers s ON s.plan_id = p.plan_id
GROUP BY p.plan_name, p.monthly_fee
ORDER BY subscribers DESC, p.monthly_fee;
GO
-- [shot:q8]
-- Q8. Top 10 data consumers (Oct + Nov 2026)
SELECT TOP 10 s.msisdn, s.full_name, p.plan_name,
       CAST(SUM(cr.data_mb) / 1024 AS DECIMAL(10,2)) AS total_gb
FROM call_records cr
JOIN subscribers s ON s.subscriber_id = cr.subscriber_id
JOIN plans p       ON p.plan_id = s.plan_id
WHERE cr.record_type = 'DATA'
GROUP BY s.msisdn, s.full_name, p.plan_name
ORDER BY total_gb DESC;
GO
-- [shot:t2]
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
-- [shot:t3]
-- Task 3. Effect of NULL on SUM and AVG (subscribers 14 and 15 have no usage rows)
SELECT s.subscriber_id, s.full_name,
       SUM(cr.duration_sec) / 60 AS voice_minutes
FROM subscribers s
LEFT JOIN call_records cr ON cr.subscriber_id = s.subscriber_id AND cr.record_type = 'VOICE'
WHERE s.subscriber_id IN (1, 2, 14, 15)
GROUP BY s.subscriber_id, s.full_name;

WITH per_sub AS (
    SELECT s.subscriber_id, SUM(cr.duration_sec) / 60.0 AS voice_minutes   -- NULL when no rows
    FROM subscribers s
    LEFT JOIN call_records cr ON cr.subscriber_id = s.subscriber_id AND cr.record_type = 'VOICE'
    GROUP BY s.subscriber_id
)
SELECT COUNT(*)                                          AS subscribers,
       COUNT(voice_minutes)                              AS with_usage,
       CAST(SUM(voice_minutes) AS DECIMAL(10,1))         AS total_minutes,
       CAST(AVG(voice_minutes) AS DECIMAL(10,1))         AS avg_ignoring_null,
       CAST(AVG(ISNULL(voice_minutes, 0)) AS DECIMAL(10,1)) AS avg_null_as_zero
FROM per_sub;
GO
