-- SQLite indexes
CREATE INDEX IF NOT EXISTS idx_price_asset ON fact_price_daily(asset_id);