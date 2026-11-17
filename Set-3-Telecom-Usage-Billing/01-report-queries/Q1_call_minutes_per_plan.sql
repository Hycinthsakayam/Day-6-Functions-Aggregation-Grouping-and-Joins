USE TelecomDB;
GO

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
