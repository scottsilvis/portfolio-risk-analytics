-- SQLite staging schema
CREATE TABLE fact_price_daily (
  date_key      INTEGER NOT NULL,
  asset_id      TEXT NOT NULL,
  close_price   REAL NOT NULL,
  daily_return  REAL NOT NULL,
  vol_regime    TEXT NOT NULL,
  PRIMARY KEY (date_key, asset_id),
  FOREIGN KEY (date_key) REFERENCES dim_date(date_key),
  FOREIGN KEY (asset_id) REFERENCES dim_asset(asset_id)
);

