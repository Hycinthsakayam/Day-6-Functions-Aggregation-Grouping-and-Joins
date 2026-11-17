USE InsuranceDB;
GO

-- Q3. Customers with more than one active policy
SELECT c.customer_id, c.full_name, COUNT(*) AS active_policies
FROM customers c
JOIN policies p ON p.customer_id = c.customer_id
WHERE p.status = 'Active'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(*) > 1
ORDER BY active_policies DESC, c.customer_id;
GO
