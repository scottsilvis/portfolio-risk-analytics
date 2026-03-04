library(dplyr)

# Flow-adjusted simple return:
# r.t = (V.t - V.{t-1} - Flow.t) / V.{t-1}
compute_flow_adjusted_returns <- function(df) {

  df %>%
    arrange(date) %>%
    mutate(
      lag_value = lag(total_market_value),
      portfolio_return = (total_market_value - lag_value - net_flow) / lag_value
    )
}