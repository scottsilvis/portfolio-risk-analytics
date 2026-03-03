-- SQLite indexes
CREATE INDEX IF NOT EXISTS idx_holdings_portfolio ON stg_fact_holding_daily(portfolio_id);