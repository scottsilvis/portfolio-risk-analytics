library(DBI)
library(RSQLite)

RAW_DIR <- "data/raw"
DB_PATH <- "data/warehouse/portfolio_analytics.db"
DDL_PATH <- "sql/01_schema_staging.sql"

TABLES <- data.frame(
  table = c(
    "stg_dim_date",
    "stg_dim_account",
    "stg_dim_portfolio",
    "stg_dim_asset",
    "stg_fact_price_daily",
    "stg_fact_transaction",
    "stg_fact_holding_daily",
    "stg_fact_portfolio_daily"
  ),
  file = c(
    "dim_date.csv",
    "dim_account.csv",
    "dim_portfolio.csv",
    "dim_asset.csv",
    "fact_price_daily.csv",
    "fact_transaction.csv",
    "fact_holding_daily.csv",
    "fact_portfolio_daily.csv"
  ),
  stringsAsFactors = FALSE
)

build_db <- function() {
  dir.create(dirname(DB_PATH), recursive = TRUE, showWarnings = FALSE)

  # validate files exist
  missing <- TABLES$file[!file.exists(file.path(RAW_DIR, TABLES$file))]
  if (length(missing) > 0) stop("Missing files in ", RAW_DIR, ": ", paste(missing, collapse = ", "))

  con <- dbConnect(RSQLite::SQLite(), DB_PATH)
  on.exit(dbDisconnect(con), add = TRUE)

  dbExecute(con, "PRAGMA foreign_keys = ON;")

  # run schema
  ddl_lines <- readLines(DDL_PATH, warn = FALSE)
  ddl <- paste(ddl_lines, collapse = "\n")

  stmts <- strsplit(ddl, ";", fixed = TRUE)[[1]]
  stmts <- trimws(stmts)
  stmts <- stmts[stmts != ""]

  for (s in stmts) {
    dbExecute(con, paste0(s, ";"))
  }

  #Boolean Normalizer
  to01 <- function(x) {
    x <- trimws(tolower(as.character(x)))
    ifelse(x %in% c("1", "true", "t", "yes", "y"), 1L,
          ifelse(x %in% c("0", "false", "f", "no", "n"), 0L, NA_integer_))
  }

  # load each CSV (clear then append to preserve constraints)
  for (i in seq_len(nrow(TABLES))) {
    tbl <- TABLES$table[i]
    f   <- file.path(RAW_DIR, TABLES$file[i])

    df <- read.csv(f, stringsAsFactors = FALSE)

    # normalize boolean-ish columns
    if (tbl == "stg_dim_date") {
      df$is_business_day <- to01(df$is_business_day)
      df$is_month_end <- to01(df$is_month_end)
    }
    if (tbl == "stg_dim_asset") {
      df$is_active <- to01(df$is_active)
    }

    dbExecute(con, paste0("DELETE FROM ", tbl, ";"))
    dbWriteTable(con, tbl, df, append = TRUE)

    cat("Loaded", basename(f), "->", tbl, "(", nrow(df), "rows)\n")
  }

  # row counts
  cat("\nRow counts:\n")
  for (tbl in TABLES$table) {
    cnt <- dbGetQuery(con, paste0("SELECT COUNT(*) AS n FROM ", tbl, ";"))$n[1]
    cat(sprintf("  %-26s %s\n", tbl, format(cnt, big.mark=",")))
  }

  cat("\nSQLite DB ready:", DB_PATH, "\n")
  }

build_db()