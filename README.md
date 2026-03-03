# Portfolio Risk Analyrics (R Edition)

## Overview

This project demonstrates a clean, reproducible portfolio risk analytics workflow implemented in R.

The goal is to focus on statistical finance fundamentals before introducing advanced modeling techniques. This project emphasizes:

* Clear data handling from raw CSV files
* Reproducible financial return calculations
* Core risk metrics used in industry
* Clean, modular project structure
* Recruiter-friendly organization

This project intentionally avoids unnecessary complexity. Advanced modeling (e.g., time series models, ML-based return prediction) may be added later.

---

## Project Philosophy

This repository is structured to:

1. Build statistical intuition first
2. Keep code simple and readable
3. Separate reusable functions from analysis scripts
4. Mirror professional R project structure

The focus is on learning and demonstrating understanding, not maximizing technical complexity.

---

## Project Structure

```
portfolio-risk-analytics/
│
├── data/                  # Local CSV files (not tracked in Git)
├── R/                     # Reusable functions
│   ├── load_data.R
│   ├── returns.R
│   ├── risk_metrics.R
│   └── portfolio_opt.R
│
├── analysis/              # Exploratory analysis & reports
│   └── exploratory_analysis.Rmd
│
├── portfolio-risk-analytics.Rproj
└── README.md
```

### Notes on Data

All market data is stored locally as CSV files inside the `data/` directory.

* CSV files are intentionally **excluded from version control**.
* This keeps the repository lightweight and professional.
* The project assumes users provide their own market data.

---

## Core Packages

The project uses a minimal, focused set of R packages:

* `tidyverse` — data manipulation
* `PerformanceAnalytics` — financial performance metrics
* `quantmod` — financial utilities (optional extensions)

Additional packages will only be introduced when necessary.

---

## Planned Workflow

### Stage 1 — Data Handling

* Load CSV price data
* Standardize column names
* Ensure date formatting

### Stage 2 — Return Engineering

* Compute daily returns
* Log vs simple returns comparison
* Aggregate returns

### Stage 3 — Risk Metrics

* Volatility
* Sharpe Ratio
* Maximum Drawdown
* Value at Risk (VaR)
* Conditional VaR (CVaR)

### Stage 4 — Portfolio Construction

* Equal-weight portfolio
* Basic mean-variance optimization

### Stage 5 — Extensions (Optional Future Work)

* Rolling risk metrics
* Time-series modeling
* Volatility modeling
* Machine learning return prediction

---

## Learning Goals

This project is designed to demonstrate:

* Statistical reasoning in financial contexts
* Clear functional decomposition in R
* Reproducible analytics workflows
* Clean project organization for hiring managers

The emphasis is on depth of understanding rather than breadth of tooling.

---

## Status

🚧 In Progress — Currently building core data loading and return engineering modules.
