library(DBI)

get_portfolio_value_series <- function(conn, portfolio_id) {

  sql <- "
    SELECT
      d.date AS date,
      p.total_market_value,
      p.net_flow
    FROM fact_portfolio_daily p
    JOIN dim_date d
      ON p.date_key = d.date_key
    WHERE p.portfolio_id = ?
    ORDER BY d.date
  "

  DBI::dbGetQuery(conn, sql, params = list(portfolio_id))
}