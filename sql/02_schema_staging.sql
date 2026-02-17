-- SQLite staging schema (uses table name prefixes instead of schemas)
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS stg_dim_date;
CREATE TABLE stg_dim_date (
  date_key        INTEGER PRIMARY KEY,
  date            TEXT NOT NULL,         -- ISO date: YYYY-MM-DD
  year            INTEGER NOT NULL,
  quarter         INTEGER NOT NULL,
  month           INTEGER NOT NULL,
  month_name      TEXT NOT NULL,
  day_of_month    INTEGER NOT NULL,
  weekday_name    TEXT NOT NULL,
  is_business_day INTEGER NOT NULL,      -- 0/1
  is_month_end    INTEGER NOT NULL       -- 0/1
);

DROP TABLE IF EXISTS stg_dim_account;
CREATE TABLE stg_dim_account (
  account_id     TEXT PRIMARY KEY,
  account_name   TEXT NOT NULL,
  account_type   TEXT NOT NULL,
  risk_profile   TEXT NOT NULL,
  base_currency  TEXT NOT NULL,
  open_date      TEXT NOT NULL
);

DROP TABLE IF EXISTS stg_dim_portfolio;
CREATE TABLE stg_dim_portfolio (
  portfolio_id      TEXT PRIMARY KEY,
  account_id        TEXT NOT NULL,
  portfolio_name    TEXT NOT NULL,
  strategy          TEXT NOT NULL,
  inception_date    TEXT NOT NULL,
  target_risk_band  TEXT NOT NULL
);

DROP TABLE IF EXISTS stg_dim_asset;
CREATE TABLE stg_dim_asset (
  asset_id        TEXT PRIMARY KEY,
  ticker          TEXT NOT NULL,
  asset_name      TEXT NOT NULL,
  asset_class     TEXT NOT NULL,
  sector          TEXT NOT NULL,
  region          TEXT NOT NULL,
  risk_factor     REAL NOT NULL,
  duration_years  REAL,
  is_active       INTEGER NOT NULL       -- 0/1
);

DROP TABLE IF EXISTS stg_fact_price_daily;
CREATE TABLE stg_fact_price_daily (
  date_key      INTEGER NOT NULL,
  asset_id      TEXT NOT NULL,
  close_price   REAL NOT NULL,
  daily_return  REAL NOT NULL,
  vol_regime    TEXT NOT NULL
);

DROP TABLE IF EXISTS stg_fact_transaction;
CREATE TABLE stg_fact_transaction (
  transaction_id   TEXT PRIMARY KEY,
  trade_date_key   INTEGER NOT NULL,
  portfolio_id     TEXT NOT NULL,
  asset_id         TEXT NOT NULL,
  transaction_type TEXT NOT NULL,
  quantity         REAL,
  price            REAL,
  gross_amount     REAL NOT NULL,
  fee_amount       REAL NOT NULL,
  net_amount       REAL NOT NULL,
  cash_impact      REAL NOT NULL,
  notes            TEXT
);

DROP TABLE IF EXISTS stg_fact_holding_daily;
CREATE TABLE stg_fact_holding_daily (
  date_key      INTEGER NOT NULL,
  portfolio_id  TEXT NOT NULL,
  asset_id      TEXT NOT NULL,
  quantity      REAL NOT NULL,
  market_value  REAL NOT NULL,
  cost_basis    REAL
);

DROP TABLE IF EXISTS stg_fact_portfolio_daily;
CREATE TABLE stg_fact_portfolio_daily (
  date_key            INTEGER NOT NULL,
  portfolio_id        TEXT NOT NULL,
  total_market_value  REAL NOT NULL,
  net_flow            REAL NOT NULL
);

