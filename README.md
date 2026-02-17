# Portfolio Performance & Risk Analytics Pipeline

## Overview

This project is an end-to-end analytics engineering and business analytics portfolio project that simulates a realistic investment analytics environment.

The goal is to demonstrate how an analytics engineer designs, builds, and delivers a complete analytics solution—from data generation and ETL, through a relational analytics schema, to business-facing dashboards—using Python, SQL, and Power BI.

All data is fully synthetic, generated programmatically to reflect realistic financial behavior while remaining reproducible and privacy-safe.

Although the solution runs entirely locally, it is designed using cloud-ready patterns and could be deployed to a managed data platform with minimal changes.

---

## Key Objectives

This project demonstrates:

- Analytics-oriented **schema design** (fact/dimension modeling)
- Python-driven **data generation and ETL pipelines**
- SQL-based **analytics-ready views**
- Data quality validation and reproducibility
- Power BI semantic modeling and dashboard design
- Clear documentation suitable for interviews and code review

---

## Technology Stack

| Layer | Technology |
|-----|-----------|
| Data Generation & ETL | Python |
| Database | PostgreSQL or SQL Server Express (local) |
| Analytics Layer | SQL (views, transformations) |
| BI & Visualization | Power BI Desktop |
| Configuration | YAML + `.env` |
| Version Control | Git / GitHub |

> **Note:** No cloud services (AWS, Azure, GCP) are required or used due to enterprise permission constraints. The project follows cloud-ready conventions while remaining fully local.

---

## Project Domain

**Portfolio Performance & Risk Analytics**

The project simulates a simplified investment analytics platform with:

- Accounts and portfolios
- Financial assets across asset classes and sectors
- Trade and cashflow transactions
- Daily asset pricing and valuations
- Portfolio performance and risk metrics

This mirrors the type of data model and analytics pipeline commonly found in:
- Asset management
- Wealth management
- Financial planning & analysis (FP&A)
- Investment analytics teams

---

## Data Model Overview

The database follows a **star-schema-inspired design**, separating event data from state and reference data.

### Dimensions
- `dim_date`
- `dim_account`
- `dim_portfolio`
- `dim_asset`

### Fact Tables
- `fact_transaction` — executed trades and cashflows
- `fact_price` — daily asset prices and returns
- `fact_holding_daily` — daily portfolio-asset positions
- `fact_portfolio_daily` (optional) — portfolio-level daily aggregates

This design supports:
- Clean joins for BI tools
- Clear grains and business logic
- Scalable analytics views

A full data dictionary is available in `/docs/data_dictionary.md`.

---

## Pipeline Architecture

The pipeline is structured into clear, repeatable stages:

### 1. Data Generation (Python)
- Synthetic accounts, portfolios, and assets
- Correlated asset returns with volatility regimes
- Realistic transaction patterns (contributions, rebalancing, dividends, fees)

### 2. Staging & Core Loading
- Raw data loaded into staging tables
- Transformations applied into core fact and dimension tables
- Deterministic runs via seeded random generation

### 3. Validation & Quality Checks
- Referential integrity checks
- Price completeness by business date
- Holdings and valuation reconciliation
- Row count and null checks

### 4. Analytics Views
SQL views expose analytics-ready datasets:
- Portfolio valuations and returns
- Rolling risk metrics (volatility, drawdown)
- Allocation and exposure breakdowns

### 5. Business Intelligence
Power BI connects directly to the database to provide:
- Executive performance dashboards
- Risk and drawdown analysis
- Allocation and diversification views
- Transaction and cashflow analysis

---

## Power BI Dashboards

The Power BI report includes multiple pages designed to answer real business questions:

1. **Executive Summary**  
   High-level performance, AUM, volatility, and drawdown KPIs

2. **Performance Analysis**  
   Portfolio returns over time and asset-level contribution

3. **Risk Metrics**  
   Rolling volatility, drawdowns, and risk indicators

4. **Allocation & Diversification**  
   Asset class, sector, and concentration analysis

5. **Transactions & Flows**  
   Contributions, withdrawals, and trading activity

All dashboards are built on a semantic model aligned with the underlying SQL schema.

---

## Repository Structure

```text
portfolio-risk-analytics/
│
├── README.md
├── .env.example
├── config/
│   └── config.yaml
│
├── sql/
│   ├── 00_create_db.sql
│   ├── 01_schema_core.sql
│   ├── 02_schema_staging.sql
│   └── 03_views_analytics.sql
│
├── src/
│   └── portfolio_analytics/
│       ├── generate/
│       ├── etl/
│       ├── validate/
│       └── orchestration/
│
├── powerbi/
│   └── PortfolioRiskAnalytics.pbix
│
├── docs/
│   ├── architecture.md
│   ├── data_dictionary.md
│   └── design_decisions.md
│
└── tests/
```

## Running the Project Locally

Create a local database (PostgreSQL or SQL Server Express)

Copy .env.example to .env and configure connection details

Run database schema scripts in /sql

Execute the Python pipeline:

python src/portfolio_analytics/orchestration/run_pipeline.py


Open the Power BI .pbix file and refresh the dataset

Design Philosophy

This project intentionally emphasizes:

Reproducibility over realism

Clear data contracts between pipeline stages

Separation of concerns (generation, transformation, analytics)

Business-aligned metrics, not academic finance complexity

The result is a project that mirrors how analytics engineering work is performed in production environments—without unnecessary tooling or infrastructure overhead.

Possible Extensions

Benchmark index comparison

Multi-currency portfolios

More advanced performance attribution

Deployment to a cloud data warehouse

Automated scheduling and CI validation

License

This project is provided for educational and portfolio purposes.
