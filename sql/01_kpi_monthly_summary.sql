-- ============================================
-- 01_kpi_monthly_summary.sql
-- Monthly KPI Summary
-- Skills: GROUP BY, Aggregations, ROUND, SAFE_DIVIDE
-- ============================================
-- Purpose: Provides a monthly breakdown of key performance
-- indicators including total orders, revenue, average shipping
-- days, and late delivery percentage. This query powers the
-- executive scorecard and helps identify seasonal trends.
-- ============================================
 
SELECT
  order_year,
  order_month_name,
  COUNT(*) AS total_orders,
  ROUND(SUM(sales), 2) AS total_revenue,
  ROUND(AVG(order_profit_per_order), 2) AS avg_profit,
  ROUND(AVG(days_for_shipping_real), 1) AS avg_ship_days,
  ROUND(
    SAFE_DIVIDE(
      SUM(late_delivery_flag),
      COUNT(*)
    ) * 100, 1
  ) AS late_delivery_pct
FROM sc_warehouse.fact_orders
GROUP BY order_year, order_month_name, order_month
ORDER BY order_year, order_month;
