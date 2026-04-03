SELECT
  order_date,
  SUM(sales) AS daily_revenue,
  SUM(SUM(sales)) OVER (
    ORDER BY order_date
  ) AS cumulative_revenue
FROM sc_warehouse.fact_orders
GROUP BY order_date
ORDER BY order_date;
