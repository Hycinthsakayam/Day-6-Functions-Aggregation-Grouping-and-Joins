USE InsuranceDB;
GO

-- Task 2. Masked policy number and policy age band (DATEADD, DATEDIFF, CASE, string functions)
SELECT CONCAT(LEFT(p.policy_no, 3), REPLICATE('*', LEN(p.policy_no) - 7), RIGHT(p.policy_no, 4)) AS masked_policy_no,
       UPPER(c.full_name) AS customer,
       p.start_date,
       CASE WHEN DATEDIFF(MONTH, p.start_date, GETDATE()) < 6  THEN 'New (under 6 months)'
            WHEN DATEDIFF(MONTH, p.start_date, GETDATE()) < 12 THEN '6-12 months'
            WHEN DATEDIFF(MONTH, p.start_date, GETDATE()) < 36 THEN '1-3 years'
            ELSE 'Over 3 years' END AS policy_age_band,
       DATEADD(DAY, 1, p.end_date) AS renewal_due_on
FROM policies p
JOIN customers c ON c.customer_id = p.customer_id
WHERE p.status = 'Active'
ORDER BY p.start_date;
GO
