-- Day 6 - Set 2 : Insurance Policy Reporting
-- reports.sql  (run setup.sql first)

USE InsuranceDB;
GO
-- [shot:q1]
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
-- [shot:q2]
-- Q2. Premium collected per product
SELECT pr.product_name, COUNT(*) AS payments, SUM(pm.amount) AS premium_collected
FROM premiums pm
JOIN policies p  ON p.policy_id = pm.policy_id
JOIN products pr ON pr.product_id = p.product_id
GROUP BY pr.product_name
ORDER BY premium_collected DESC;
GO
-- [shot:q3]
-- Q3. Customers with more than one active policy
SELECT c.customer_id, c.full_name, COUNT(*) AS active_policies
FROM customers c
JOIN policies p ON p.customer_id = c.customer_id
WHERE p.status = 'Active'
GROUP BY c.customer_id, c.full_name
HAVING COUNT(*) > 1
ORDER BY active_policies DESC, c.customer_id;
GO
-- [shot:q4]
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
-- [shot:q5]
-- Q5. Policies without any claim
SELECT p.policy_no, c.full_name, pr.product_name, p.status
FROM policies p
JOIN customers c   ON c.customer_id = p.customer_id
JOIN products pr   ON pr.product_id = p.product_id
LEFT JOIN claims cl ON cl.policy_id = p.policy_id
WHERE cl.claim_id IS NULL
ORDER BY p.policy_id;
GO
-- [shot:q6]
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
-- [shot:q7]
-- Q7. New policies per month (last 12 months)
SELECT FORMAT(start_date, 'yyyy-MM') AS start_month, COUNT(*) AS new_policies,
       SUM(annual_premium) AS premium_written
FROM policies
WHERE start_date >= DATEADD(MONTH, -12, CAST(GETDATE() AS DATE))
GROUP BY FORMAT(start_date, 'yyyy-MM')
ORDER BY start_month;
GO
-- [shot:q8]
-- Q8. Top 5 agents by premium collected
SELECT TOP 5 a.agent_name, a.city, COUNT(DISTINCT p.policy_id) AS policies,
       SUM(pm.amount) AS premium_collected
FROM agents a
JOIN policies p  ON p.agent_id = a.agent_id
JOIN premiums pm ON pm.policy_id = p.policy_id
GROUP BY a.agent_name, a.city
ORDER BY premium_collected DESC;
GO
-- [shot:t2]
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
-- [shot:t3_where]
-- Task 3. WHERE vs HAVING (using Q3)
-- (a) without WHERE : expired policies are also counted, so Divya Menon wrongly appears
SELECT c.full_name, COUNT(*) AS policies
FROM customers c JOIN policies p ON p.customer_id = c.customer_id
GROUP BY c.full_name
HAVING COUNT(*) > 1
ORDER BY c.full_name;
GO
-- [shot:t3_error]
-- (b) aggregate in WHERE is not allowed
SELECT c.full_name, COUNT(*) AS policies
FROM customers c JOIN policies p ON p.customer_id = c.customer_id
WHERE COUNT(*) > 1
GROUP BY c.full_name;
GO
