source("r/db.R")
source("r/portfolio_queries.R")
source("r/returns.R")

library(dplyr)

conn <- connect_db()
on.exit(DBI::dbDisconnect(conn), add = TRUE)

portfolio_id <- 1

ts <- get_portfolio_value_series(conn, portfolio_id)
rets <- compute_flow_adjusted_returns(ts)

print(head(rets, 10))
print(summary(rets$portfolio_return))

plot(rets$date, rets$portfolio_return, type = "l")