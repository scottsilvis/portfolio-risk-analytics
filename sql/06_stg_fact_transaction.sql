-- SQLite staging schemas
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
  notes            TEXT,
  FOREIGN KEY (trade_date_key) REFERENCES stg_dim_date (date_key),
  FOREIGN KEY (portfolio_id) REFERENCES stg_dim_portfolio (portfolio_id),
  FOREIGN KEY (asset_id) REFERENCES stg_dim_asset (asset_id)
);
