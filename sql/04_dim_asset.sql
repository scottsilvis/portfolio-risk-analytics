-- SQLite staging schema
CREATE TABLE dim_asset (
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

