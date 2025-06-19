-- PostgreSQL: Pastikan order_date jadi DATE
WITH rfm AS (
  SELECT
    customer_id,
    (CURRENT_DATE - MAX(order_date::DATE)) AS recency,
    COUNT(order_id) AS frequency,
    SUM(payment_value) AS monetary
  FROM e_commerce_transactions
  GROUP BY customer_id
)
SELECT * FROM rfm;
