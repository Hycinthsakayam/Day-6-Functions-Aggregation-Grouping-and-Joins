USE TelecomDB;
GO

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
