USE InsuranceDB;
GO

-- Task 3. WHERE vs HAVING (using Q3)
-- (a) without WHERE : expired policies are also counted, so Divya Menon wrongly appears
SELECT c.full_name, COUNT(*) AS policies
FROM customers c JOIN policies p ON p.customer_id = c.customer_id
GROUP BY c.full_name
HAVING COUNT(*) > 1
ORDER BY c.full_name;
GO
