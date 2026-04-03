-- ============================================
-- 04_customer_segmentation.sql
-- Customer Segmentation by Spend
-- Skills: CTE, CASE, GROUP BY, Aggregations
-- ============================================
-- Purpose: Segments customers into High, Medium, and Low
-- value tiers based on their total spend. Uses a CTE
-- (Common Table Expression) to first calculate per-customer
-- metrics, then categorizes them. This analysis reveals
-- how revenue is distributed across customer segments and
-- helps prioritize retention efforts.
-- ============================================
 
WITH customer_stats AS (
  SELECT
    f.customer_id,
    c.customer_fname,
    c.customer_lname,
    c.customer_segment,
    COUNT(*) AS order_count,
    ROUND(SUM(f.sales), 2) AS total_spend,
    ROUND(AVG(f.order_profit_per_order), 2) AS avg_profit,
    ROUND(AVG(f.days_for_shipping_real), 1) AS avg_ship_days,
    ROUND(
      SAFE_DIVIDE(
        SUM(f.late_delivery_flag),
        COUNT(*)
      ) * 100, 1
    ) AS late_pct
  FROM sc_warehouse.fact_orders f
  JOIN sc_warehouse.dim_customer c
    ON f.customer_id = c.customer_id
  GROUP BY
    f.customer_id,
    c.customer_fname,
    c.customer_lname,
    c.customer_segment
)
 
SELECT
  CASE
    WHEN total_spend > 5000 THEN 'High Value'
    WHEN total_spend > 1000 THEN 'Medium Value'
    ELSE 'Low Value'
  END AS value_segment,
  COUNT(*) AS num_customers,
  ROUND(AVG(total_spend), 2) AS avg_spend,
  ROUND(AVG(order_count), 1) AS avg_orders,
  ROUND(AVG(avg_profit), 2) AS avg_profit_per_order,
  ROUND(SUM(total_spend), 2) AS segment_total_revenue,
  ROUND(
    SAFE_DIVIDE(
      SUM(total_spend),
      (SELECT SUM(total_spend) FROM customer_stats)
    ) * 100, 1
  ) AS pct_of_total_revenue,
  ROUND(AVG(late_pct), 1) AS avg_late_delivery_pct
FROM customer_stats
GROUP BY value_segment
ORDER BY avg_spend DESC
