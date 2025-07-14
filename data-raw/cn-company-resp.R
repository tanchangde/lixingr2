library(httr2)
library(magrittr)
library(jsonlite)
library(lixingr2)

resp_lxr_cn_com_trading_abnormal <- lxr_cn_com_trading_abnormal(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2020-03-01",
  end_date = "2025-07-01",
  stock_code = "300750",
  .return_format = "tibble"
)

resp_lxr_cn_com_trading_abnormal |>
  httr2::resp_body_json(simplifyVector = TRUE) %>%
  magrittr::use_series("data") |>
  jsonlite::toJSON(auto_unbox = TRUE, pretty = TRUE) |>
  write("./tests/testthat/fixtures/cn_com_trading_abnormal_resp.json")
