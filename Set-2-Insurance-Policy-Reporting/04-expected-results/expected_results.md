# Task 4 – Expected Result of Every Query

Results were checked by running `setup.sql` and `reports.sql` on SQL Server 2025 Express. Screenshots are in [01-report-queries](../01-report-queries/).

| Query | Purpose | Expected result |
|---|---|---|
| [Q1](../01-report-queries/Q1_policies_expiring_30_days.sql) | Policies expiring in the next 30 days | 3 rows: HLT2025000101 (13 days), MOT2025000105 (22), TRV2026000108 (28) |
| [Q2](../01-report-queries/Q2_premium_per_product.sql) | Premium collected per product | 5 rows: Term Life Plus 2,94,000 highest, Travel Safe 4,300 lowest |
| [Q3](../01-report-queries/Q3_customers_more_than_1_active_policy.sql) | Customers with more than one active policy | 6 rows: Karthik Raja 3; Arun, Vikram, Priya, Sanjay, Imran 2 each |
| [Q4](../01-report-queries/Q4_claim_ratio_per_product.sql) | Claim ratio per product | 5 rows: Health 91.14%, Motor 72.94%, Home 68.26%, Life and Travel 0% |
| [Q5](../01-report-queries/Q5_policies_without_claims.sql) | Policies without claims | 8 rows incl. all three life and both travel policies |
| [Q6](../01-report-queries/Q6_avg_premium_by_age_band.sql) | Average premium by age band | 4 bands: 60+ highest at 42,000, 18-29 lowest at 4,900 |
| [Q7](../01-report-queries/Q7_monthly_new_policies.sql) | Monthly new policies (last 12 months) | 11 rows from 2025-12 to 2026-11 |
| [Q8](../01-report-queries/Q8_top5_agents_by_premium.sql) | Top 5 agents by premium | 5 rows: Suresh Kumar first with 2,90,900 |
