USE RetailSalesDB;
GO

-- Task 3. NULL behaviour : discount is NULL when no coupon was used
SELECT COUNT(*)                 AS count_star,
       COUNT(discount)          AS count_discount,
       SUM(discount)            AS sum_discount,
       AVG(discount)            AS avg_discount,
       AVG(ISNULL(discount, 0)) AS avg_discount_null_as_zero
FROM orders;
GO
