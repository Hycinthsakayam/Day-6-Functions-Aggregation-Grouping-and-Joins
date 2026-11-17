USE InsuranceDB;
GO

-- Q2. Premium collected per product
SELECT pr.product_name, COUNT(*) AS payments, SUM(pm.amount) AS premium_collected
FROM premiums pm
JOIN policies p  ON p.policy_id = pm.policy_id
JOIN products pr ON pr.product_id = p.product_id
GROUP BY pr.product_name
ORDER BY premium_collected DESC;
GO
