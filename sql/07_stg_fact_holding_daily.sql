-- SQLite staging schema 
CREATE TABLE stg_fact_holding_daily (
  date_key      INTEGER NOT NULL,
  portfolio_id  TEXT NOT NULL,
  asset_id      TEXT NOT NULL,
  quantity      REAL NOT NULL,
  market_value  REAL NOT NULL,
  cost_basis    REAL,
  PRIMARY KEY (date_key, portfolio_id, asset_id),
  FOREIGN KEY (date_key) REFERENCES stg_dim_date (date_key),
  FOREIGN KEY (portfolio_id) REFERENCES stg_dim_portfolio (portfolio_id),
  FOREIGN KEY (asset_id) REFERENCES stg_dim_asset (asset_id)
);

