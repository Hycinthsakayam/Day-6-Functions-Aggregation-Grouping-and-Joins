-- Day 6 - Set 1 : Retail Sales Reporting
-- setup.sql : tables and sample data used by reports.sql

USE master;
GO
IF DB_ID('RetailSalesDB') IS NOT NULL
BEGIN
    ALTER DATABASE RetailSalesDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RetailSalesDB;
END
GO
CREATE DATABASE RetailSalesDB;
GO
USE RetailSalesDB;
GO
CREATE TABLE customers (
    customer_id  INT PRIMARY KEY,
    full_name    VARCHAR(60)  NOT NULL,
    city         VARCHAR(40)  NOT NULL,
    joined_on    DATE         NOT NULL,
    email        VARCHAR(80)  NULL
);
CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(60)   NOT NULL,
    category     VARCHAR(40)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL CHECK (unit_price > 0)
);
CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT          NOT NULL REFERENCES customers(customer_id),
    order_date   DATE         NOT NULL,
    status       VARCHAR(10)  NOT NULL DEFAULT 'Delivered' CHECK (status IN ('Delivered', 'Cancelled')),
    discount     DECIMAL(10,2) NULL          -- NULL = no coupon used
);
CREATE TABLE order_items (
    order_id     INT NOT NULL REFERENCES orders(order_id),
    product_id   INT NOT NULL REFERENCES products(product_id),
    quantity     INT NOT NULL CHECK (quantity > 0),
    unit_price   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id)
);
CREATE TABLE payments (
    payment_id   INT IDENTITY(1,1) PRIMARY KEY,
    order_id     INT NOT NULL UNIQUE REFERENCES orders(order_id),
    amount       DECIMAL(10,2) NOT NULL,
    payment_mode VARCHAR(10)   NOT NULL,
    paid_on      DATE          NOT NULL
);
GO

INSERT INTO customers (customer_id, full_name, city, joined_on, email) VALUES
(1, 'Arun Prakash', 'Chennai', '2025-01-12', 'arun.p@mail.com'),
(2, 'Divya Menon', 'Chennai', '2025-03-05', NULL),
(3, 'Karthik Raja', 'Bengaluru', '2025-02-20', 'karthik.r@mail.com'),
(4, 'Meena Iyer', 'Bengaluru', '2025-06-11', 'meena.i@mail.com'),
(5, 'Rahul Sharma', 'Hyderabad', '2025-07-01', NULL),
(6, 'Sneha Patil', 'Hyderabad', '2025-09-15', 'sneha.p@mail.com'),
(7, 'Vikram Singh', 'Mumbai', '2025-11-30', 'vikram.s@mail.com'),
(8, 'Priya Nair', 'Mumbai', '2026-01-08', NULL),
(9, 'Lakshmi Devi', 'Chennai', '2026-04-22', 'lakshmi.d@mail.com'),
(10, 'Sanjay Gupta', 'Bengaluru', '2026-08-19', 'sanjay.g@mail.com'),
(11, 'Nithya Ramesh', 'Hyderabad', '2026-10-01', NULL);

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
(1, 'Bluetooth Speaker', 'Electronics', 1499.00),
(2, 'USB-C Charger 25W', 'Electronics', 899.00),
(3, 'Wireless Mouse', 'Electronics', 649.00),
(4, 'Basmati Rice 5kg', 'Groceries', 645.00),
(5, 'Cold Pressed Oil 1L', 'Groceries', 320.00),
(6, 'Mixer Grinder 750W', 'Home & Kitchen', 3299.00),
(7, 'Non-stick Tawa', 'Home & Kitchen', 799.00),
(8, 'Cotton Kurta', 'Clothing', 799.00),
(9, 'Running Shoes', 'Footwear', 2199.00),
(10, 'Smart Watch', 'Electronics', 3499.00);

INSERT INTO orders (order_id, customer_id, order_date, status, discount) VALUES
(1, 1, '2026-08-03', 'Delivered', 100),
(2, 3, '2026-08-07', 'Delivered', NULL),
(3, 5, '2026-08-12', 'Delivered', 200),
(4, 1, '2026-08-18', 'Delivered', NULL),
(5, 2, '2026-08-25', 'Delivered', 50),
(6, 7, '2026-09-02', 'Delivered', NULL),
(7, 3, '2026-09-06', 'Delivered', 150),
(8, 5, '2026-09-10', 'Delivered', NULL),
(9, 1, '2026-09-15', 'Delivered', NULL),
(10, 4, '2026-09-21', 'Delivered', 100),
(11, 6, '2026-09-27', 'Cancelled', NULL),
(12, 8, '2026-10-04', 'Delivered', NULL),
(13, 3, '2026-10-09', 'Delivered', 0),
(14, 5, '2026-10-14', 'Delivered', 300),
(15, 1, '2026-10-20', 'Delivered', 500),
(16, 9, '2026-10-20', 'Delivered', 250),
(17, 7, '2026-10-20', 'Delivered', NULL),
(18, 2, '2026-10-26', 'Delivered', NULL),
(19, 4, '2026-11-02', 'Delivered', 100),
(20, 3, '2026-11-05', 'Delivered', NULL),
(21, 5, '2026-11-08', 'Delivered', NULL),
(22, 1, '2026-11-11', 'Delivered', 0),
(23, 6, '2026-11-13', 'Delivered', NULL),
(24, 8, '2026-11-15', 'Delivered', 200);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 1499.00),
(1, 3, 1, 649.00),
(2, 4, 2, 645.00),
(2, 5, 3, 320.00),
(3, 6, 1, 3299.00),
(4, 8, 2, 799.00),
(5, 2, 1, 899.00),
(5, 5, 2, 320.00),
(6, 9, 1, 2199.00),
(7, 10, 1, 3499.00),
(8, 4, 3, 645.00),
(9, 7, 1, 799.00),
(9, 5, 1, 320.00),
(10, 1, 1, 1499.00),
(10, 2, 1, 899.00),
(11, 9, 1, 2199.00),
(12, 8, 3, 799.00),
(13, 3, 2, 649.00),
(13, 4, 1, 645.00),
(14, 10, 1, 3499.00),
(14, 1, 1, 1499.00),
(15, 6, 1, 3299.00),
(15, 10, 1, 3499.00),
(16, 9, 2, 2199.00),
(16, 1, 1, 1499.00),
(17, 4, 2, 645.00),
(18, 7, 2, 799.00),
(19, 10, 1, 3499.00),
(20, 5, 4, 320.00),
(20, 4, 2, 645.00),
(21, 2, 2, 899.00),
(22, 9, 1, 2199.00),
(22, 8, 1, 799.00),
(23, 3, 1, 649.00),
(24, 6, 1, 3299.00);

INSERT INTO payments (order_id, amount, payment_mode, paid_on) VALUES
(1, 2048.00, 'UPI', '2026-08-03'),
(2, 2250.00, 'Card', '2026-08-07'),
(3, 3099.00, 'UPI', '2026-08-12'),
(4, 1598.00, 'COD', '2026-08-18'),
(5, 1489.00, 'UPI', '2026-08-25'),
(6, 2199.00, 'Card', '2026-09-02'),
(7, 3349.00, 'Card', '2026-09-06'),
(8, 1935.00, 'UPI', '2026-09-10'),
(9, 1119.00, 'UPI', '2026-09-15'),
(10, 2298.00, 'Card', '2026-09-21'),
(12, 2397.00, 'COD', '2026-10-04'),
(13, 1943.00, 'UPI', '2026-10-09'),
(14, 4698.00, 'Card', '2026-10-14'),
(15, 6298.00, 'Card', '2026-10-20'),
(16, 5647.00, 'UPI', '2026-10-20'),
(17, 1290.00, 'COD', '2026-10-20'),
(18, 1598.00, 'UPI', '2026-10-26'),
(19, 3399.00, 'Card', '2026-11-02'),
(20, 2570.00, 'UPI', '2026-11-05'),
(22, 2998.00, 'UPI', '2026-11-11');
GO
