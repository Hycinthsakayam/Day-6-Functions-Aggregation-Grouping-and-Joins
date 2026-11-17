USE InsuranceDB;
GO

-- Q1. Policies expiring in the next 30 days
SELECT p.policy_no, c.full_name, pr.product_name, p.end_date,
       DATEDIFF(DAY, CAST(GETDATE() AS DATE), p.end_date) AS days_left
FROM policies p
JOIN customers c ON c.customer_id = p.customer_id
JOIN products pr ON pr.product_id = p.product_id
WHERE p.status = 'Active'
  AND p.end_date BETWEEN CAST(GETDATE() AS DATE) AND DATEADD(DAY, 30, CAST(GETDATE() AS DATE))
ORDER BY p.end_date;
GO
