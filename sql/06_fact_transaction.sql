-- SQLite staging schemas
CREATE TABLE fact_transaction (
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
  notes            TEXT,
  FOREIGN KEY (trade_date_key) REFERENCES dim_date (date_key),
  FOREIGN KEY (portfolio_id) REFERENCES dim_portfolio (portfolio_id),
  FOREIGN KEY (asset_id) REFERENCES dim_asset (asset_id)
);
