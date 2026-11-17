USE InsuranceDB;
GO

-- Q8. Top 5 agents by premium collected
SELECT TOP 5 a.agent_name, a.city, COUNT(DISTINCT p.policy_id) AS policies,
       SUM(pm.amount) AS premium_collected
FROM agents a
JOIN policies p  ON p.agent_id = a.agent_id
JOIN premiums pm ON pm.policy_id = p.policy_id
GROUP BY a.agent_name, a.city
ORDER BY premium_collected DESC;
GO
