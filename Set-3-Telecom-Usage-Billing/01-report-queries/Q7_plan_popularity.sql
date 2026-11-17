USE TelecomDB;
GO

-- Q7. Plan popularity
SELECT p.plan_name, p.monthly_fee, COUNT(s.subscriber_id) AS subscribers,
       CAST(COUNT(s.subscriber_id) * 100.0 / (SELECT COUNT(*) FROM subscribers) AS DECIMAL(5,2)) AS share_percent
FROM plans p
LEFT JOIN subscribers s ON s.plan_id = p.plan_id
GROUP BY p.plan_name, p.monthly_fee
ORDER BY subscribers DESC, p.monthly_fee;
GO
