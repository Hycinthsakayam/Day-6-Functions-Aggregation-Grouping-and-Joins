USE TelecomDB;
GO

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
