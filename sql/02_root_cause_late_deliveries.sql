-- ============================================
-- 02_root_cause_late_deliveries.sql
-- Root Cause Analysis: Late Deliveries
-- Skills: JOIN, WHERE, GROUP BY, ORDER BY
-- ============================================
-- Purpose: Identifies which product categories and markets
-- are responsible for the highest number of late deliveries.
-- This root cause analysis helps leadership prioritize
-- supply chain improvements by showing where delays are
-- concentrated and the revenue at risk.
-- ============================================
 
SELECT
  p.category_name,
  f.market,
  COUNT(*) AS late_orders,
  ROUND(AVG(f.delivery_delay_days), 1) AS avg_delay_days,
  ROUND(SUM(f.sales), 2) AS revenue_at_risk,
  ROUND(AVG(f.order_profit_per_order), 2) AS avg_profit_impact,
  ROUND(
    SAFE_DIVIDE(
      COUNT(*),
      SUM(COUNT(*)) OVER ()
    ) * 100, 1
  ) AS pct_of_all_late_orders
FROM sc_warehouse.fact_orders f
JOIN sc_warehouse.dim_product p
  ON f.product_card_id = p.product_card_id
WHERE f.late_delivery_flag = 1
GROUP BY
  p.category_name,
  f.market
ORDER BY late_orders DESC
LIMIT 15;
