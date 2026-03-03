-- SQLite staging schema
CREATE TABLE stg_fact_portfolio_daily (
  date_key            INTEGER NOT NULL,
  portfolio_id        TEXT NOT NULL,
  total_market_value  REAL NOT NULL,
  net_flow            REAL NOT NULL,
  PRIMARY KEY (date_key, portfolio_id),
  FOREIGN KEY (date_key) REFERENCES stg_dim_date (date_key),
  FOREIGN KEY (portfolio_id) REFERENCES stg_dim_portfolio (portfolio_id)
);
