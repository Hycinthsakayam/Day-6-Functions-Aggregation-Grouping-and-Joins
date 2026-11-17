USE InsuranceDB;
GO

-- (b) aggregate in WHERE is not allowed
SELECT c.full_name, COUNT(*) AS policies
FROM customers c JOIN policies p ON p.customer_id = c.customer_id
WHERE COUNT(*) > 1
GROUP BY c.full_name;
GO
