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
  "./tests/testthat/fixtures/cn_com.json"
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

resp_cn_com_major_shareholders_shares_change <-
  lxr_cn_com_major_shareholders_shares_change(
    token = Sys.getenv("LIXINGR_TOKEN"),
    stock_code = "300750",
    start_date = "2015-07-01",
    end_date = "2025-07-01",
    limit = 5,
    .return_format = "resp"
  )

save_json_response(
  resp_cn_com_major_shareholders_shares_change,
  "./tests/testthat/fixtures/cn_com_major_shareholders_shares_change.json"
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
  "./tests/testthat/fixtures/cn_com_trading_abnormal.json"
)

resp_cn_com_block_deal <- lxr_cn_com_block_deal(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2015-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_block_deal,
  "./tests/testthat/fixtures/cn_com_block_deal.json"
)

resp_cn_com_pledge <- lxr_cn_com_pledge(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2022-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_pledge,
  "./tests/testthat/fixtures/cn_com_pledge.json"
)

resp_cn_com_operation_revenue_constitution <- lxr_cn_com_operation_revenue_constitution(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2023-07-01",
  end_date = "2025-07-15",
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_operation_revenue_constitution,
  "./tests/testthat/fixtures/cn_com_operation_revenue_constitution.json"
)

resp_cn_com_indices <- lxr_cn_com_indices(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "600900",
  date = "2023-07-01",
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_indices,
  "./tests/testthat/fixtures/cn_com_indices.json"
)

resp_cn_com_industries <- lxr_cn_com_industries(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  date = "2025-07-01",
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_industries,
  "./tests/testthat/fixtures/cn_com_industries.json"
)

resp_cn_com_announcement <- lxr_cn_com_announcement(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-15",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_announcement,
  "./tests/testthat/fixtures/cn_com_announcement.json"
)

resp_cn_com_measures <- lxr_cn_com_measures(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "600866",
  start_date = "2016-07-01",
  end_date = "2025-07-15",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_measures,
  "./tests/testthat/fixtures/cn_com_measures.json"
)

resp_cn_com_inquiry <- lxr_cn_com_inquiry(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "600866",
  start_date = "2015-07-15",
  end_date = "2025-07-15",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_inquiry,
  "./tests/testthat/fixtures/cn_com_inquiry.json"
)

resp_cn_com_majority_shareholders <- lxr_cn_com_majority_shareholders(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-07-15",
  end_date = "2025-07-15",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_majority_shareholders,
  "./tests/testthat/fixtures/cn_com_majority_shareholders.json"
)

resp_cn_com_nolimit_shareholders <- lxr_cn_com_nolimit_shareholders(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_nolimit_shareholders,
  "./tests/testthat/fixtures/cn_com_nolimit_shareholders.json"
)

resp_cn_com_fund_shareholders <- lxr_cn_com_fund_shareholders(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_fund_shareholders,
  "./tests/testthat/fixtures/cn_com_fund_shareholders.json"
)

resp_cn_com_fund_collection_shareholders <- lxr_cn_com_fund_collection_shareholders(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_fund_collection_shareholders,
  "./tests/testthat/fixtures/cn_com_fund_collection_shareholders.json"
)

resp_cn_com_dividend <- lxr_cn_com_dividend(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_dividend,
  "./tests/testthat/fixtures/cn_com_dividend.json"
)

resp_cn_com_allotment <- lxr_cn_com_allotment(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "600958",
  start_date = "2015-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_allotment,
  "./tests/testthat/fixtures/cn_com_allotment.json"
)

resp_cn_com_customers <- lxr_cn_com_customers(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2023-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .return_format = "resp"
)

save_json_response(
  resp_cn_com_customers,
  "./tests/testthat/fixtures/cn_com_customers.json"
)
