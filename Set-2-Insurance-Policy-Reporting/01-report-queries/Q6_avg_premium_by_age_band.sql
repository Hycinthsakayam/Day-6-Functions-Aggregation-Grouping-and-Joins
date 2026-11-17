USE InsuranceDB;
GO

-- Q6. Average annual premium by customer age band
WITH cust_age AS (
    SELECT customer_id, FLOOR(DATEDIFF(DAY, date_of_birth, GETDATE()) / 365.25) AS age
    FROM customers
)
SELECT CASE WHEN a.age < 30 THEN '18-29'
            WHEN a.age < 45 THEN '30-44'
            WHEN a.age < 60 THEN '45-59'
            ELSE '60+' END                         AS age_band,
       COUNT(*)                                    AS policies,
       CAST(AVG(p.annual_premium) AS DECIMAL(10,2)) AS avg_premium
FROM policies p
JOIN cust_age a ON a.customer_id = p.customer_id
GROUP BY CASE WHEN a.age < 30 THEN '18-29'
              WHEN a.age < 45 THEN '30-44'
              WHEN a.age < 60 THEN '45-59'
              ELSE '60+' END
ORDER BY age_band;
GO
