# Supply Chain Cloud Analytics Pipeline

End-to-end BI pipeline analyzing **180K+ supply chain orders** to identify root causes of late deliveries across global markets. Built entirely using cloud-based tools — Python ETL, BigQuery data warehouse, SQL analysis, and Tableau dashboard.

## Architecture

```
Kaggle CSV → Python ETL (Google Colab) → BigQuery Data Warehouse → SQL Analysis → Tableau Dashboard
```

## Tools & Skills

| Tool | Usage |
|------|-------|
| **Python (pandas)** | ETL pipeline — extract from CSV, clean data, transform into star schema, load to BigQuery |
| **Google BigQuery** | Cloud data warehouse with star schema (4 tables, 180K+ records) |
| **SQL** | Complex analytical queries: JOINs, CTEs, window functions, CASE statements |
| **Tableau Public** | Interactive executive dashboard with 6 views and cross-filtering |
| **Google Colab** | Cloud-based Python notebook — zero local installs required |

## Star Schema Design

| Table | Records | Description |
|-------|---------|-------------|
| **fact_orders** | 180,519 | Order records with sales, profit, shipping metrics, late delivery flags |
| **dim_product** | Unique products | Product name, category, department, price |
| **dim_customer** | Unique customers | Customer segment, city, state, country |
| **dim_region** | Unique regions | Market, region, country, city mapping |

## Key SQL Analyses

| # | Query | Technique | File |
|---|-------|-----------|------|
| 01 | Monthly KPI Summary | GROUP BY, aggregations, SAFE_DIVIDE | [01_kpi_monthly_summary.sql](sql/01_kpi_monthly_summary.sql) |
| 02 | Root Cause: Late Deliveries | JOIN, WHERE, window function | [02_root_cause_late_deliveries.sql](sql/02_root_cause_late_deliveries.sql) |
| 03 | Cumulative Revenue | Window function (SUM OVER), moving average | [03_cumulative_revenue.sql](sql/03_cumulative_revenue.sql) |
| 04 | Customer Segmentation | CTE, CASE, JOIN, subquery | [04_customer_segmentation.sql](sql/04_customer_segmentation.sql) |
| 05 | Shipping Mode Comparison | GROUP BY, SAFE_DIVIDE, aggregations | [05_shipping_mode_analysis.sql](sql/05_shipping_mode_analysis.sql) |

## Key Findings

- **57.3%** of all orders were delivered late across all markets
- **Cleats** was the product category with the highest number of late deliveries
- **Europe** and **Pacific Asia** had the highest late delivery percentages (~55-60%)
- **First Class** shipping had the worst late delivery rate despite being a premium option
- **Fan Shop** was the most profitable department by total profit
- Total revenue across all orders: **$36.8M** with average shipping time of **3.5 days**

## Dashboard

![Supply Chain Performance Dashboard](tableau/dashboard_screenshot.png)

*Dashboard features: KPI summary cards, revenue trend over time, late deliveries by product category, market performance comparison, shipping mode analysis, and department profit treemap. Cross-filtering enabled for interactive exploration.*

## Repository Structure

```
supply-chain-cloud-analytics/
├── README.md
├── notebooks/
│   └── supply_chain_etl.ipynb          # Python ETL pipeline (Google Colab)
├── sql/
│   ├── 01_kpi_monthly_summary.sql      # Monthly KPIs: revenue, orders, late %
│   ├── 02_root_cause_late_deliveries.sql   # Root cause analysis with JOINs
│   ├── 03_cumulative_revenue.sql       # Running total with window functions
│   ├── 04_customer_segmentation.sql    # Customer tiers using CTEs
│   └── 05_shipping_mode_analysis.sql   # Shipping performance comparison
└── tableau/
    └── dashboard_screenshot.png        # Dashboard screenshot
```

## About

This project was built to demonstrate end-to-end BI engineering skills for Business Intelligence and Data Analyst roles. It covers the full analytics pipeline: data extraction, transformation, warehousing, SQL analysis, and visualization — mirroring the day-to-day work of a BI Engineer.
