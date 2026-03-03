-- SQLite staging schema
CREATE TABLE stg_fact_price_daily (
  date_key      INTEGER NOT NULL,
  asset_id      TEXT NOT NULL,
  close_price   REAL NOT NULL,
  daily_return  REAL NOT NULL,
  vol_regime    TEXT NOT NULL,
  PRIMARY KEY (date_key, asset_id),
  FOREIGN KEY (date_key) REFERENCES stg_dim_date(date_key),
  FOREIGN KEY (asset_id) REFERENCES stg_dim_asset(asset_id)
);

