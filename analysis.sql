-- 1. Pembuatan RFM --
WITH rfm AS (
  SELECT
    customer_id,
    (CURRENT_DATE - MAX(order_date::DATE)) AS recency,
    COUNT(order_id) AS frequency,
    SUM(payment_value) AS monetary
  FROM e_commerce_transactions
  GROUP BY customer_id
),
ranked AS (
  SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    NTILE(5) OVER (ORDER BY recency ASC) AS r_score,
    NTILE(5) OVER (ORDER BY frequency DESC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary DESC) AS m_score
  FROM rfm
)
SELECT
  *,
  CASE
    WHEN r_score = 5 AND f_score = 5 AND m_score = 5 THEN 'Champions'
    WHEN r_score >= 4 AND f_score >= 4 THEN 'Loyal Customers'
    WHEN r_score >= 3 AND f_score >= 3 THEN 'Potential Loyalist'
    WHEN r_score >= 3 AND f_score <= 2 THEN 'Needs Attention'
    WHEN r_score <= 2 AND f_score >= 4 THEN 'At Risk'
    WHEN r_score = 1 AND f_score = 1 THEN 'Lost'
    ELSE 'Others'
  END AS segment
FROM ranked;

-- 2. Deteksi Anomaly --

SELECT 
  MIN(decoy_noise) AS min_noise,
  MAX(decoy_noise) AS max_noise,
  AVG(decoy_noise) AS avg_noise,
  SUM(CASE WHEN decoy_noise < 0 THEN 1 ELSE 0 END) AS negative_noise_count
FROM e_commerce_transactions;

-- Anomali ke 2 --
WITH stats AS (
  SELECT
    AVG(payment_value) AS mean_payment,
    STDDEV(payment_value) AS std_payment,
    AVG(decoy_noise) AS mean_noise,
    STDDEV(decoy_noise) AS std_noise
  FROM e_commerce_transactions
)
SELECT *
FROM e_commerce_transactions, stats
WHERE 
  payment_value > (mean_payment + 3 * std_payment)
  OR decoy_noise > (mean_noise + 3 * std_noise)
  OR decoy_noise < 0;

