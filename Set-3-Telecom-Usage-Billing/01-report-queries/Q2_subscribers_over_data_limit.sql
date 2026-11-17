USE TelecomDB;
GO

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
