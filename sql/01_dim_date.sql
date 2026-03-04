-- SQLite staging schema (uses table name prefixes instead of schemas)
CREATE TABLE dim_date (
  date_key        INTEGER PRIMARY KEY,
  date            TEXT NOT NULL,         -- ISO date: YYYY-MM-DD
  year            INTEGER NOT NULL,
  quarter         INTEGER NOT NULL,
  month           INTEGER NOT NULL,
  month_name      TEXT NOT NULL,
  day_of_month    INTEGER NOT NULL,
  weekday_name    TEXT NOT NULL,
  is_business_day INTEGER NOT NULL,      -- 0/1
  is_month_end    INTEGER NOT NULL       -- 0/1
);

