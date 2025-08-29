library(httr2)
library(magrittr)
library(jsonlite)
library(lixingr2)

save_json_response <- function(resp, path) {
  resp |>
    httr2::resp_body_json(simplifyVector = TRUE) %>%
    magrittr::use_series("data") |>
    jsonlite::toJSON(auto_unbox = TRUE, pretty = TRUE) |>
    write(path)
}

resp_hk_com <- lxr_hk_com(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_hk_com,
  "./tests/testthat/fixtures/hk_com.json"
)

resp_hk_com_candlestick <- lxr_hk_com_candlestick(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  type = "lxr_fc_rights",
  start_date = "2025-06-01",
  end_date = "2025-07-01",
  limit = 5,
  .config = list(return_format = "resp")
)

save_json_response(
  resp_hk_com_candlestick,
  "./tests/testthat/fixtures/hk_com_candlestick.json"
)

resp_hk_com_operation_revenue_constitution <- lxr_hk_com_operation_revenue_constitution(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2024-07-01",
  end_date = "2025-07-15",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_hk_com_operation_revenue_constitution,
  "./tests/testthat/fixtures/hk_com_operation_revenue_constitution.json"
)
