-- SQLite staging schema
CREATE TABLE fact_portfolio_daily (
  date_key            INTEGER NOT NULL,
  portfolio_id        TEXT NOT NULL,
  total_market_value  REAL NOT NULL,
  net_flow            REAL NOT NULL,
  PRIMARY KEY (date_key, portfolio_id),
  FOREIGN KEY (date_key) REFERENCES dim_date (date_key),
  FOREIGN KEY (portfolio_id) REFERENCES dim_portfolio (portfolio_id)
);
