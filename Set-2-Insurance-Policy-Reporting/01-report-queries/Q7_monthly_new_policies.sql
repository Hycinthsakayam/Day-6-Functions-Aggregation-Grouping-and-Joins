USE InsuranceDB;
GO

-- Q7. New policies per month (last 12 months)
SELECT FORMAT(start_date, 'yyyy-MM') AS start_month, COUNT(*) AS new_policies,
       SUM(annual_premium) AS premium_written
FROM policies
WHERE start_date >= DATEADD(MONTH, -12, CAST(GETDATE() AS DATE))
GROUP BY FORMAT(start_date, 'yyyy-MM')
ORDER BY start_month;
GO
