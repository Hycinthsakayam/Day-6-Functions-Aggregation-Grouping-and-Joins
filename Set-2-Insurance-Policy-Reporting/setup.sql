-- Day 6 - Set 2 : Insurance Policy Reporting
-- setup.sql : tables and sample data used by reports.sql

USE master;
GO
IF DB_ID('InsuranceDB') IS NOT NULL
BEGIN
    ALTER DATABASE InsuranceDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE InsuranceDB;
END
GO
CREATE DATABASE InsuranceDB;
GO
USE InsuranceDB;
GO
CREATE TABLE customers (
    customer_id    INT PRIMARY KEY,
    full_name      VARCHAR(60) NOT NULL,
    date_of_birth  DATE        NOT NULL,
    city           VARCHAR(40) NOT NULL
);
CREATE TABLE agents (
    agent_id    INT PRIMARY KEY,
    agent_name  VARCHAR(60) NOT NULL,
    city        VARCHAR(40) NOT NULL
);
CREATE TABLE products (
    product_id        INT PRIMARY KEY,
    product_name      VARCHAR(40) NOT NULL,
    line_of_business  VARCHAR(20) NOT NULL
);
CREATE TABLE policies (
    policy_id       INT PRIMARY KEY,
    policy_no       CHAR(13)      NOT NULL UNIQUE,
    customer_id     INT           NOT NULL REFERENCES customers(customer_id),
    product_id      INT           NOT NULL REFERENCES products(product_id),
    agent_id        INT           NOT NULL REFERENCES agents(agent_id),
    start_date      DATE          NOT NULL,
    end_date        DATE          NOT NULL,
    annual_premium  DECIMAL(10,2) NOT NULL CHECK (annual_premium > 0),
    status          VARCHAR(10)   NOT NULL CHECK (status IN ('Active', 'Expired')),
    CHECK (end_date > start_date)
);
CREATE TABLE premiums (
    premium_id  INT IDENTITY(1,1) PRIMARY KEY,
    policy_id   INT           NOT NULL REFERENCES policies(policy_id),
    paid_on     DATE          NOT NULL,
    amount      DECIMAL(10,2) NOT NULL CHECK (amount > 0)
);
CREATE TABLE claims (
    claim_id         INT PRIMARY KEY,
    policy_id        INT           NOT NULL REFERENCES policies(policy_id),
    claim_date       DATE          NOT NULL,
    claimed_amount   DECIMAL(12,2) NOT NULL,
    approved_amount  DECIMAL(12,2) NULL,        -- NULL until the claim is decided
    status           VARCHAR(10)   NOT NULL CHECK (status IN ('Open', 'In Review', 'Settled', 'Rejected')),
    settled_on       DATE          NULL
);
GO

INSERT INTO customers (customer_id, full_name, date_of_birth, city) VALUES
(1, 'Arun Prakash', '1980-03-14', 'Chennai'),
(2, 'Divya Menon', '1992-07-22', 'Chennai'),
(3, 'Karthik Raja', '1975-11-05', 'Bengaluru'),
(4, 'Meena Iyer', '1968-01-30', 'Bengaluru'),
(5, 'Rahul Sharma', '2001-09-18', 'Hyderabad'),
(6, 'Sneha Patil', '1996-04-02', 'Hyderabad'),
(7, 'Vikram Singh', '1958-12-25', 'Mumbai'),
(8, 'Priya Nair', '1988-06-10', 'Mumbai'),
(9, 'Lakshmi Devi', '1950-08-08', 'Chennai'),
(10, 'Sanjay Gupta', '1985-02-14', 'Bengaluru'),
(11, 'Nithya Ramesh', '1999-10-01', 'Chennai'),
(12, 'Imran Khan', '1972-05-20', 'Hyderabad');

INSERT INTO agents (agent_id, agent_name, city) VALUES
(1, 'Suresh Kumar', 'Chennai'),
(2, 'Anitha Raj', 'Chennai'),
(3, 'Mohan Das', 'Bengaluru'),
(4, 'Kavya Reddy', 'Hyderabad'),
(5, 'Imran Sheikh', 'Hyderabad'),
(6, 'Deepa Joseph', 'Mumbai');

INSERT INTO products (product_id, product_name, line_of_business) VALUES
(1, 'Health Shield', 'Health'),
(2, 'Motor Secure', 'Motor'),
(3, 'Term Life Plus', 'Life'),
(4, 'Travel Safe', 'Travel'),
(5, 'Home Protect', 'Home');

INSERT INTO policies (policy_id, policy_no, customer_id, product_id, agent_id, start_date, end_date, annual_premium, status) VALUES
(1, 'HLT2025000101', 1, 1, 1, '2025-12-01', '2026-11-30', 18000.00, 'Active'),
(2, 'MOT2026000102', 1, 2, 2, '2026-03-10', '2027-03-09', 9500.00, 'Active'),
(3, 'LIF2022000103', 3, 3, 1, '2022-06-15', '2042-06-14', 24000.00, 'Active'),
(4, 'HLT2026000104', 3, 1, 3, '2026-01-20', '2027-01-19', 21000.00, 'Active'),
(5, 'MOT2025000105', 3, 2, 3, '2025-12-10', '2026-12-09', 11000.00, 'Active'),
(6, 'HME2024000106', 4, 5, 4, '2024-08-01', '2027-07-31', 7500.00, 'Active'),
(7, 'HLT2025000107', 5, 1, 5, '2025-07-05', '2026-07-04', 8000.00, 'Expired'),
(8, 'TRV2026000108', 6, 4, 4, '2026-11-10', '2026-12-15', 2500.00, 'Active'),
(9, 'LIF2023000109', 7, 3, 1, '2023-02-01', '2033-01-31', 36000.00, 'Active'),
(10, 'HLT2026000110', 7, 1, 2, '2026-04-12', '2027-04-11', 42000.00, 'Active'),
(11, 'MOT2026000111', 8, 2, 6, '2026-05-18', '2027-05-17', 12500.00, 'Active'),
(12, 'HLT2026000112', 9, 1, 2, '2026-06-01', '2027-05-31', 48000.00, 'Active'),
(13, 'HME2026000113', 10, 5, 5, '2026-07-22', '2027-07-21', 6800.00, 'Active'),
(14, 'MOT2025000114', 10, 2, 6, '2025-12-28', '2026-12-27', 10200.00, 'Active'),
(15, 'TRV2026000115', 11, 4, 3, '2026-09-02', '2026-09-20', 1800.00, 'Expired'),
(16, 'HLT2026000116', 12, 1, 4, '2026-08-14', '2027-08-13', 26000.00, 'Active'),
(17, 'LIF2026000117', 12, 3, 5, '2026-10-05', '2046-10-04', 30000.00, 'Active'),
(18, 'MOT2026000118', 2, 2, 1, '2026-10-19', '2027-10-18', 8900.00, 'Active'),
(19, 'HLT2025000119', 2, 1, 6, '2025-11-01', '2026-10-31', 15000.00, 'Expired'),
(20, 'HLT2026000120', 8, 1, 3, '2026-11-03', '2027-11-02', 19500.00, 'Active');

INSERT INTO premiums (policy_id, paid_on, amount) VALUES
(1, '2025-12-01', 18000.00),
(2, '2026-03-10', 9500.00),
(3, '2022-06-15', 24000.00),
(3, '2023-06-15', 24000.00),
(3, '2024-06-15', 24000.00),
(3, '2025-06-15', 24000.00),
(3, '2026-06-15', 24000.00),
(4, '2026-01-20', 21000.00),
(5, '2025-12-10', 11000.00),
(6, '2024-08-01', 7500.00),
(6, '2025-08-01', 7500.00),
(6, '2026-08-01', 7500.00),
(7, '2025-07-05', 8000.00),
(8, '2026-11-10', 2500.00),
(9, '2023-02-01', 36000.00),
(9, '2024-02-01', 36000.00),
(9, '2025-02-01', 36000.00),
(9, '2026-02-01', 36000.00),
(10, '2026-04-12', 42000.00),
(11, '2026-05-18', 12500.00),
(12, '2026-06-01', 48000.00),
(13, '2026-07-22', 6800.00),
(14, '2025-12-28', 10200.00),
(15, '2026-09-02', 1800.00),
(16, '2026-08-14', 26000.00),
(17, '2026-10-05', 30000.00),
(18, '2026-10-19', 8900.00),
(19, '2025-11-01', 15000.00),
(20, '2026-11-03', 19500.00);

INSERT INTO claims (claim_id, policy_id, claim_date, claimed_amount, approved_amount, status, settled_on) VALUES
(1, 1, '2026-03-14', 32000.00, 30000.00, 'Settled', '2026-03-29'),
(2, 2, '2026-06-02', 42000.00, 38000.00, 'Settled', '2026-06-20'),
(3, 4, '2026-05-11', 26000.00, 24000.00, 'Settled', '2026-05-30'),
(4, 5, '2026-02-08', 15000.00, NULL, 'Rejected', NULL),
(5, 7, '2026-01-22', 15000.00, 13500.00, 'Settled', '2026-02-15'),
(6, 6, '2026-08-15', 45000.00, NULL, 'In Review', NULL),
(7, 10, '2026-09-03', 72000.00, 65000.00, 'Settled', '2026-10-01'),
(8, 11, '2026-10-28', 28000.00, NULL, 'In Review', NULL),
(9, 12, '2026-07-19', 34000.00, 31000.00, 'Settled', '2026-08-05'),
(10, 14, '2026-11-05', 9000.00, NULL, 'Open', NULL),
(11, 16, '2026-10-10', 18000.00, 16500.00, 'Settled', '2026-10-30'),
(12, 13, '2026-09-25', 22000.00, 20000.00, 'Settled', '2026-10-20');
GO
