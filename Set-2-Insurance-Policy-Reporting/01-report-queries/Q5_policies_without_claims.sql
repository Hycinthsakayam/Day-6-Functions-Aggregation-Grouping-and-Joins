USE InsuranceDB;
GO

-- Q5. Policies without any claim
SELECT p.policy_no, c.full_name, pr.product_name, p.status
FROM policies p
JOIN customers c   ON c.customer_id = p.customer_id
JOIN products pr   ON pr.product_id = p.product_id
LEFT JOIN claims cl ON cl.policy_id = p.policy_id
WHERE cl.claim_id IS NULL
ORDER BY p.policy_id;
GO
