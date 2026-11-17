USE InsuranceDB;
GO

-- Q4. Claim ratio per product = settled claim amount / premium collected
WITH prem AS (
    SELECT p.product_id, SUM(pm.amount) AS premium
    FROM premiums pm JOIN policies p ON p.policy_id = pm.policy_id
    GROUP BY p.product_id
),
paid AS (
    SELECT p.product_id, SUM(cl.approved_amount) AS claims_paid
    FROM claims cl JOIN policies p ON p.policy_id = cl.policy_id
    WHERE cl.status = 'Settled'
    GROUP BY p.product_id
)
SELECT pr.product_name, prem.premium,
       ISNULL(paid.claims_paid, 0) AS claims_paid,
       CAST(ISNULL(paid.claims_paid, 0) * 100.0 / prem.premium AS DECIMAL(6,2)) AS claim_ratio_percent
FROM products pr
JOIN prem      ON prem.product_id = pr.product_id
LEFT JOIN paid ON paid.product_id = pr.product_id
ORDER BY claim_ratio_percent DESC;
GO
