-- SQLite staging schema 
CREATE TABLE fact_holding_daily (
  date_key      INTEGER NOT NULL,
  portfolio_id  TEXT NOT NULL,
  asset_id      TEXT NOT NULL,
  quantity      REAL NOT NULL,
  market_value  REAL NOT NULL,
  cost_basis    REAL,
  PRIMARY KEY (date_key, portfolio_id, asset_id),
  FOREIGN KEY (date_key) REFERENCES dim_date (date_key),
  FOREIGN KEY (portfolio_id) REFERENCES dim_portfolio (portfolio_id),
  FOREIGN KEY (asset_id) REFERENCES dim_asset (asset_id)
);

