# Portfolio Risk Analyrics (R Edition)

## Overview

This project demonstrates a clean, reproducible portfolio risk analytics workflow implemented in R and SQLite.

The goal is to build a small analytics warehouse from raw market data and then compute portfolio returns and risk metrics using clear statistical methods.This project emphasizes:

- Clean ingestion of raw CSV market data
- Simple relational data modeling
- Reproducible return calculations
- Core portfolio risk metrics used in industry
- Clear separation between data engineering (SQL) and analysis (R)

The focus is on statistical understanding and clean structure, not maximizing technical complexity.

Advanced modeling (e.g., machine learning or advanced time-series models) may be added later.

---

## Project Philosophy

This repository is structured to:

1. Build financial intuition first
2. Keep code simple and readable
3. Separate data engineering from analysis scripts
4. Mirror professional R project structure
5. PRoduce a portfolio=quality GitHub project

The focus is on learning and demonstrating understanding, not maximizing technical complexity.

---

## Why SQLite?

This project uses SQLite as a lightweight analytics warehouse.

Advantages:

- Single portable database file
- No server setup required
- Fully reproducible environment
- Clean separation between raw data and analysis
- Mirrors warehouse workflows used in production analytics

SQLite allows me to demonstrate analytics engineering concepts without requiring cloud infrastructure.

---

## Project Structure

```
portfolio-risk-analytics/
│
├── data/                  
│   ├── raw/                            # Local CSV files (not tracked in Git)
│   └── warehouse/
│       └── portfolio_analytics.db      # not tracked in Git
│
├── r/                              
│   └── build_sqlite.R
│
├── sql/
│   ├── 01_dim_date.sql
│   ├── 02_dim_account.sql
│   ├── 03_dim_portfolio.sql
│   ├── 04_dim_asset.sql
│   ├── 05_fact_price_daily.sql
│   ├── 06_fact_transaction.sql
│   ├── 07_fact_holding_daily.sql
│   ├── 08_fact_portfolio_daily.sql
│   ├── 09_idx_price_asset.sql
│   └── 10_idx_holdings_portfolio.sql
│
├── analysis/                           # R analysis scripts and reports
│
├── docs/                               # Optional documentation
│
├── powerbi/                            # Optional visualization layer
│
└── README.md
```
---

## Data Model

### Dimension Tables

These provide descriptive metadata.

|Table	| Description
|--- |---
|dim_date	|Calendar information for time series analysis
|dim_asset	|Asset metadata (ticker, asset class, etc.)
|dim_portfolio	|Portfolio identifiers
|dim_account	|Account identifiers


### Fact Tables

These capture events or measurements over time.

|Table	| Description
|--- |---
|fact_price_daily	|Daily asset prices and returns
|fact_transaction	|Portfolio transactions
|fact_holding_daily	|Daily portfolio holdings
|fact_portfolio_daily	|Portfolio-level market value and flows

### Key Fields

#### fact_price_daily
|Column	|Description
|--- |---
|date_key	|Trading date
|asset_id	|Asset identifier
|close_price	|Closing market price
|daily_return	|Daily asset return
|vol_regime	|Volatility regime label


#### fact_holding_daily
|Column	|Description
|--- |---
date_key	|Trading date
portfolio_id	|Portfolio identifier
asset_id	|Asset identifier
quantity	|Units held
market_value	|Market value of position
cost_basis	|Original cost of position

#### fact_portfolio_daily
|Column	|Description
|--- |---
date_key	|Trading date
portfolio_id	|Portfolio identifier
total_market_value	|Total portfolio market value
net_flow	|Capital inflow/outflow

---

## Analysis Workflow

The analysis proceeds in four stages.

### Stage 1 — Data Engineering

Raw CSV files are loaded into a SQLite analytics warehouse using SQL scripts.

Steps:

1. Raw CSV files placed in data/raw/
2. SQL scripts create dimension and fact tables
3. build.sqlite.R executes the build pipeline
4. Resulting database stored in:
```
data/warehouse/portfolio_analytics.db
```
---

### Stage 2 — Return Engineering

Using R, the project computes portfolio returns from the warehouse data.

Two approaches are possible:

#### 1. Portfolio-Level Returns

Using:
```
fact_portfolio_daily
```

Returns are derived from the portfolio value time series.

This approach is useful for:
- Portfolio risk analysis
- Performance reporting
- Flow-adjusted return calculations

---

#### 2. Holdings-Based Returns

Using:

```
fact_holding_daily + fact_price_daily
```

Portfolio returns are reconstructed from asset-level returns and portfolio weights.

This enables:

- Risk attribution
- Asset contribution analysis
- Portfolio construction experiments

---

### Stage 3 — Risk Metrics

Core portfolio risk metrics are computed in R:

- Volatility
- Sharpe Ratio
- Maximum Drawdown
- Value at Risk (VaR)
- Conditional VaR (CVaR)

These metrics are commonly used in professional portfolio analysis.

--- 

### Stage 4 — Portfolio Construction

Initial analysis focuses on a single portfolio.

Later extensions may include:

- Multi-portfolio comparison
- Equal-weight portfolio construction
- Mean-variance optimization
- Core R Packages

The project intentionally uses a minimal set of packages:

|Package	|Purpose
|---|---
|tidyverse	|Data manipulation
|DBI	|Database connections
|RSQLite	|SQLite interface
|PerformanceAnalytics	|Risk metrics

Additional packages may be introduced only when necessary.

---

## Learning Goals

This project demonstrates:
- Portfolio risk analysis fundamentals
- Financial return engineering
- Relational data modeling for analytics
- Reproducible R workflows
- Clean project organization suitable for hiring managers

The emphasis is on depth of understanding, not tooling complexity.

---

## Status

In Progress

Current progress:

1. SQLite warehouse structure (Complete)
2. Data model defined (Complete)
3. Building R modules for return engineering
4. Risk metrics implementation
5. Portfolio optimization extensions