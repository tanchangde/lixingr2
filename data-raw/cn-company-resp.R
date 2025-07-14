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

resp_cn_com <- lxr_cn_com(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = c("300750", "600519", "600157"),
  .return_format = "resp"
)

save_json_response(
  resp_cn_com,
  "./tests/testthat/fixtures/cn_com_resp.json"
)

resp_cn_com_profile <- lxr_cn_com_profile(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = c("300750", "600519", "600579"),
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_profile,
  "./tests/testthat/fixtures/cn_com_profile.json"
)

resp_cn_com_equity_change <- lxr_cn_com_equity_change(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-10-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_equity_change,
  "./tests/testthat/fixtures/cn_com_equity_change.json"
)

resp_cn_com_candlestick <- lxr_cn_com_candlestick(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  type = "ex_rights",
  start_date = "2025-06-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_candlestick,
  "./tests/testthat/fixtures/cn_com_candlestick.json"
)

resp_cn_com_shareholders_num <- lxr_cn_com_shareholders_num(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-06-01",
  end_date = "2025-07-01",
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_shareholders_num,
  "./tests/testthat/fixtures/cn_com_shareholders_num.json"
)

resp_cn_com_senior_executive_shares_change <-
  lxr_cn_com_senior_executive_shares_change(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2020-07-08",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_senior_executive_shares_change,
  "./tests/testthat/fixtures/cn_com_senior_executive_shares_change.json"
)

resp_cn_com_trading_abnormal <- lxr_cn_com_trading_abnormal(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2020-03-01",
  end_date = "2025-07-01",
  stock_code = "300750",
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_trading_abnormal,
  "./tests/testthat/fixtures/cn_com_trading_abnormal_resp.json"
)
