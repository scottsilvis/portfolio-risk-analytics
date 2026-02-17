from pathlib import Path
import sqlite3
import pandas as pd

RAW_DIR = Path("data/raw")
DB_PATH = Path("data/warehouse/portfolio_analytics.db")
DDL_PATH = Path("sql/02_schema_staging.sql")

TABLES = [
    ("stg_dim_date", "dim_date.csv"),
    ("stg_dim_account", "dim_account.csv"),
    ("stg_dim_portfolio", "dim_portfolio.csv"),
    ("stg_dim_asset", "dim_asset.csv"),
    ("stg_fact_price_daily", "fact_price_daily.csv"),
    ("stg_fact_transaction", "fact_transaction.csv"),
    ("stg_fact_holding_daily", "fact_holding_daily.csv"),
    ("stg_fact_portfolio_daily", "fact_portfolio_daily.csv"),
]

def main():
    # Ensure folders exist
    DB_PATH.parent.mkdir(parents=True, exist_ok=True)

    # Validate raw files exist
    missing = [fn for _, fn in TABLES if not (RAW_DIR / fn).exists()]
    if missing:
        raise FileNotFoundError(f"Missing files in {RAW_DIR}: {missing}")

    # Create DB + staging tables
    with sqlite3.connect(DB_PATH) as conn:
        conn.execute("PRAGMA foreign_keys = ON;")
        ddl = DDL_PATH.read_text(encoding="utf-8")
        conn.executescript(ddl)

        # Load each CSV into staging (replace to avoid accidental duplicates)
        for table, filename in TABLES:
            path = RAW_DIR / filename
            df = pd.read_csv(path)

            # normalize boolean-ish columns for SQLite (0/1)
            if table == "stg_dim_date":
                df["is_business_day"] = df["is_business_day"].astype(int)
                df["is_month_end"] = df["is_month_end"].astype(int)
            if table == "stg_dim_asset":
                df["is_active"] = df["is_active"].astype(int)

            print(f"Loading {filename} -> {table} ({len(df):,} rows)")
            df.to_sql(table, conn, if_exists="replace", index=False)

        # Row count sanity checks
        print("\nRow counts:")
        for table, _ in TABLES:
            cnt = conn.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
            print(f"  {table:<26} {cnt:,}")

    print(f"\n SQLite DB ready: {DB_PATH}")

if __name__ == "__main__":
    main()
