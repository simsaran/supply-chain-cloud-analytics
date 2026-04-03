-- ============================================
-- 05_shipping_mode_analysis.sql
-- Shipping Mode Performance Comparison
-- Skills: GROUP BY, SAFE_DIVIDE, Aggregations
-- ============================================
-- Purpose: Compares delivery performance across different
-- shipping methods (Standard, First Class, Second Class,
-- Same Day). This analysis reveals which shipping modes
-- have the highest late delivery rates and helps identify
-- whether premium shipping actually delivers better results.
-- ============================================
 
SELECT
  shipping_mode,
  COUNT(*) AS total_orders,
  ROUND(SUM(sales), 2) AS total_revenue,
  ROUND(AVG(sales), 2) AS avg_order_value,
  ROUND(AVG(days_for_shipping_real), 1) AS avg_actual_ship_days,
  ROUND(AVG(days_for_shipment_scheduled), 1) AS avg_scheduled_ship_days,
  ROUND(AVG(delivery_delay_days), 1) AS avg_delay_days,
  SUM(late_delivery_flag) AS late_orders,
  ROUND(
    SAFE_DIVIDE(
      SUM(late_delivery_flag),
      COUNT(*)
    ) * 100, 1
  ) AS late_delivery_pct,
  ROUND(AVG(order_profit_per_order), 2) AS avg_profit
FROM sc_warehouse.fact_orders
GROUP BY shipping_mode
ORDER BY late_delivery_pct DESC;
 
