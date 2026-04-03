WITH customer_stats AS (
  SELECT
    customer_id,
    COUNT(*) AS order_count,
    ROUND(SUM(sales), 2) AS total_spend,
    ROUND(AVG(order_profit_per_order), 2) AS avg_profit
  FROM sc_warehouse.fact_orders
  GROUP BY customer_id
)
SELECT
  CASE
    WHEN total_spend > 5000 THEN 'High Value'
    WHEN total_spend > 1000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS customer_segment,
  COUNT(*) AS num_customers,
  ROUND(AVG(total_spend), 2) AS avg_spend,
  ROUND(AVG(order_count), 1) AS avg_orders
FROM customer_stats
GROUP BY customer_segment
ORDER BY avg_spend DESC;
