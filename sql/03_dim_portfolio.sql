-- SQLite staging schema
CREATE TABLE dim_portfolio (
  portfolio_id      TEXT PRIMARY KEY,
  account_id        TEXT NOT NULL,
  portfolio_name    TEXT NOT NULL,
  strategy          TEXT NOT NULL,
  inception_date    TEXT NOT NULL,
  target_risk_band  TEXT NOT NULL,
  FOREIGN KEY (account_id) REFERENCES dim_account(account_id)
);

