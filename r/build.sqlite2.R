# Load raw CSVs into SQLite and apply schema.

library(DBI)
library(RSQLite)
library(readr)

stopifnot(
  dir.exists("sql"),
  dir.exists("data")
)
message("Working directory: ", getwd())
message("Folders /sql and /data found")

# ---- Paths ----

data_tables <- c(
  "dim_date",
  "dim_account",
  "dim_portfolio",
  "dim_asset",
  "fact_price_daily",
  "fact_transaction",
  "fact_holding_daily",
  "fact_portfolio_daily"
)

stg_tables <- paste0("stg_", data_tables)

schema_files <- c(data_tables, "idx_price_asset", "idx_holdings_portfolio")

schema_paths <- paste0(
    "sql/", 
    sprintf("%02d", seq_along(schema_files)), 
    "_stg_", 
    schema_files, 
    ".sql"
  )

db_path <- "data/warehouse/portfolio_analytics.db"

data_dir <- file.path("data/raw/")  

file_names <- setNames(
  paste0(data_dir, "/", data_tables, ".csv"),
  data_tables
)

message("paths created")

stopifnot(all(file.exists(schema_paths)))
stopifnot(all(file.exists(unlist(file_names))))

message("paths validated")
# ---- Connect ----
  
conn <- dbConnect(RSQLite::SQLite(), db_path)
dbExecute(conn, "PRAGMA foreign_keys = ON;")
message("connected to SQLite: ", db_path)

# ---- create schema ----
  
# NOTE: This drops existing tables if you rerun.

for (t in stg_tables) dbExecute(conn, paste0("DROP TABLE IF EXISTS ", t, ";"))

stopifnot(all(file.exists(schema_paths)))
for (p in schema_paths) {
  message("Applying schema: ", p)
  sql <- paste(readLines(p, warn = FALSE), collapse = "\n")
  dbExecute(conn, sql)
} 

message("schema created. tables: ", paste(dbListTables(conn), collapse = ", "))

# ---- Load data ----
  
# Sites first (patients references sites; visits references both)

for (tbl in data_tables) {
  message("Loading: ", tbl, " from ", file_names[[tbl]])
  df <- read_csv(file_names[[tbl]], show_col_types = FALSE)
  dbWriteTable(conn, tbl, df, append = TRUE)
}

message("data loaded")

# ---- Basic verification ----
  
row_counts <- sapply(names(file_names), function(tbl) {
  dbGetQuery(conn, paste0("SELECT COUNT(*) AS n FROM ", tbl, ";"))$n
})
message("raw counts: ")
print(row_counts)

dbDisconnect(conn)
message('Done. SQLite DB created at: ', db_path)