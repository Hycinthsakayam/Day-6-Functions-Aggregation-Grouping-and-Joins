# Day 6 – Functions, Aggregation, Grouping and Joins

This repository contains my solutions for the Day 6 reporting assignment on SQL Server 2025 and MongoDB 8.0. Each question is in its own folder with the queries, the output and a flowchart.

The assignment has three sets, with five questions in each set.

## What I'm working on

- Writing report queries with JOIN, GROUP BY and HAVING.
- Using LEFT JOIN to find missing rows (orders without payment, policies without claims).
- Using string, date and maths functions (CONCAT, UPPER, FORMAT, DATEADD, DATEDIFF, ROUND, CASE).
- Understanding NULL in COUNT, SUM and AVG, and WHERE vs HAVING.
- Documenting the expected result of every query.
- Writing MongoDB aggregation pipelines with $match, $group and $sort.

## Assignment sets

### Set 1 – Retail Sales Reporting
Eight sales reports (top products, month-wise sales, HAVING, LEFT JOIN, revenue share), a customer-friendly output column, NULL behaviour, and three MongoDB pipelines.

[Open Set 1](./Set-1-Retail-Sales-Reporting/)

### Set 2 – Insurance Policy Reporting
Eight policy reports (expiring policies, premium per product, claim ratio, age bands, top agents), masked policy numbers, WHERE vs HAVING, and three pipelines on claim notes.

[Open Set 2](./Set-2-Insurance-Policy-Reporting/)

### Set 3 – Telecom Usage and Billing Reporting
Eight usage and billing reports (minutes per plan, data-limit breaches, overdue invoices, ARPU, top consumers), formatted invoice numbers with due status, NULL in SUM / AVG, and usage-event pipelines.

[Open Set 3](./Set-3-Telecom-Usage-Billing/)

## How the folders are organised

Each set has `setup.sql` (tables and sample data), and the two deliverables `reports.sql` and `reports.js` with every query in one file.

Each question has its own folder. Inside, you can find:

- The query files (Question 1 has one file per report, e.g. `Q1_top5_products_by_revenue.sql`).
- `output.txt` and screenshots (`*_output.png`) with the result.
- `README.md` with the question, the query and the output screenshots (it opens automatically on GitHub).
- `flowchart.svg`, which shows the steps followed.

Question 4 (`04-expected-results`) is the expected-result document.

## Running

Run `setup.sql` first, then any query file, in SQL Server Management Studio or sqlcmd. Run the MongoDB file with `mongosh`, e.g. `mongosh sales_pipelines.js`.

## A note about dates

Some reports use `GETDATE()`, so their results depend on the day they are run. The outputs here were captured on 17 Nov 2026.
