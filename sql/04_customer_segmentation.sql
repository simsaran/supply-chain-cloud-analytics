SELECT
  shipping_mode,
  COUNT(*) AS total_orders,
  ROUND(AVG(days_for_shipping_real), 1) AS avg_ship_days,
  ROUND(
    SAFE_DIVIDE(
      SUM(late_delivery_flag),
      COUNT(*)
    ) * 100, 1
  ) AS late_pct,
  ROUND(AVG(sales), 2) AS avg_order_value
FROM sc_warehouse.fact_orders
GROUP BY shipping_mode
ORDER BY late_pct DESC;
