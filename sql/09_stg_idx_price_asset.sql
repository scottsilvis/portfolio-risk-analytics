-- SQLite indexes
CREATE INDEX IF NOT EXISTS idx_price_asset ON stg_fact_price_daily(asset_id);