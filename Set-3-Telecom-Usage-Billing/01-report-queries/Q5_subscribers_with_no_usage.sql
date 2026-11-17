USE TelecomDB;
GO

-- Q5. Subscribers with no usage at all
SELECT s.msisdn, s.full_name, s.activated_on
FROM subscribers s
LEFT JOIN call_records cr ON cr.subscriber_id = s.subscriber_id
WHERE cr.record_id IS NULL;
GO
