-- ============================================
-- 03_cumulative_revenue.sql
-- Cumulative Revenue Over Time
-- Skills: Window Function (SUM OVER), GROUP BY
-- ============================================
-- Purpose: Calculates a running total of revenue over time,
-- showing how revenue accumulates day by day. Window functions
-- are an advanced SQL skill that Amazon BI roles specifically
-- look for. This query also calculates a 7-day moving average
-- to smooth out daily fluctuations.
-- ============================================
 
SELECT
  order_date,
  SUM(sales) AS daily_revenue,
  COUNT(*) AS daily_orders,
  SUM(SUM(sales)) OVER (
    ORDER BY order_date
  ) AS cumulative_revenue,
  ROUND(
    AVG(SUM(sales)) OVER (
      ORDER BY order_date
      ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ), 2
  ) AS moving_avg_7day,
  SUM(COUNT(*)) OVER (
    ORDER BY order_date
  ) AS cumulative_orders
FROM sc_warehouse.fact_orders
GROUP BY order_date
ORDER BY order_date;
