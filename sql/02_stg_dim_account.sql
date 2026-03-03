-- SQLite staging schema
CREATE TABLE stg_dim_account (
  account_id     TEXT PRIMARY KEY,
  account_name   TEXT NOT NULL,
  account_type   TEXT NOT NULL,
  risk_profile   TEXT NOT NULL,
  base_currency  TEXT NOT NULL,
  open_date      TEXT NOT NULL
);

