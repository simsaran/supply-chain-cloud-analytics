SELECT
  p.category_name,
  f.market,
  COUNT(*) AS late_orders,
  ROUND(AVG(f.delivery_delay_days), 1) AS avg_delay_days,
  ROUND(SUM(f.sales), 2) AS revenue_at_risk
FROM sc_warehouse.fact_orders f
JOIN sc_warehouse.dim_product p
  ON f.product_card_id = p.product_card_id
WHERE f.late_delivery_flag = 1
GROUP BY p.category_name, f.market
ORDER BY late_orders DESC
LIMIT 15;
