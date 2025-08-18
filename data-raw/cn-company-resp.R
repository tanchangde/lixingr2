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
  stock_codes = c("300750", "600519", "600157"),
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com,
  "./tests/testthat/fixtures/cn_com.json"
)

resp_cn_com_profile <- lxr_cn_com_profile(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = c("300750", "600519", "600579"),
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
    .config = list(return_format = "resp")
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
    .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_operation_revenue_constitution,
  "./tests/testthat/fixtures/cn_com_operation_revenue_constitution.json"
)

resp_cn_com_operating_data <- lxr_cn_com_operating_data(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "600519",
  start_date = "2023-07-01",
  end_date = "2025-07-01",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_operating_data,
  "./tests/testthat/fixtures/cn_com_operating_data.json"
)

resp_cn_com_indices <- lxr_cn_com_indices(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "600900",
  date = "2023-07-01",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_indices,
  "./tests/testthat/fixtures/cn_com_indices.json"
)

resp_cn_com_industries <- lxr_cn_com_industries(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  date = "2025-07-01",
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
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
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_customers,
  "./tests/testthat/fixtures/cn_com_customers.json"
)

resp_cn_com_suppliers <- lxr_cn_com_suppliers(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "300750",
  start_date = "2023-07-01",
  end_date = "2025-07-01",
  limit = 5,
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_suppliers,
  "./tests/testthat/fixtures/cn_com_suppliers.json"
)

resp_cn_com_fundmtl_non_financial <- lxr_cn_com_fundmtl_non_financial(
  token = Sys.getenv("LIXINGR_TOKEN"),
  date = "2025-07-08",
  stock_codes = c("300750", "600519", "600157"),
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y3.cvpos"),
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fundmtl_non_financial,
  "./tests/testthat/fixtures/cn_com_fundmtl_non_financial.json"
)

resp_cn_com_fundmtl_bank <- lxr_cn_com_fundmtl_bank(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2025-07-01",
  end_date = "2025-07-08",
  stock_codes = "600036", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fundmtl_bank,
  "./tests/testthat/fixtures/cn_com_fundmtl_bank.json"
)

resp_cn_com_fundmtl_security <- lxr_cn_com_fundmtl_security(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2025-07-01",
  end_date = "2025-07-15",
  stock_codes = "600030", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  limit = 5,
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fundmtl_security,
  "./tests/testthat/fixtures/cn_com_fundmtl_security.json"
)

resp_cn_com_fundmtl_insurance <- lxr_cn_com_fundmtl_insurance(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2025-07-01",
  end_date = "2025-07-15",
  stock_codes = "601318", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  limit = 5,
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fundmtl_insurance,
  "./tests/testthat/fixtures/cn_com_fundmtl_insurance.json"
)

resp_cn_com_fundmtl_other_financial <- lxr_cn_com_fundmtl_other_financial(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2025-07-01",
  end_date = "2025-07-15",
  stock_codes = "600901", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  limit = 5,
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fundmtl_other_financial,
  "./tests/testthat/fixtures/cn_com_fundmtl_other_financial.json"
)

resp_cn_com_fs_non_financial <- lxr_cn_com_fs_non_financial(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  stock_codes = "300750", ,
  metrics_list = "q.ps.toi.t",
  limit = 5,
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fs_non_financial,
  "./tests/testthat/fixtures/cn_com_fs_non_financial.json"
)

resp_cn_com_fs_bank <- lxr_cn_com_fs_bank(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "300750", ,
  metrics_list = "q.ps.oi.t",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fs_bank,
  "./tests/testthat/fixtures/cn_com_fs_bank.json"
)

resp_cn_com_fs_security <- lxr_cn_com_fs_security(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "300750", ,
  metrics_list = "q.ps.oi.t",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fs_security,
  "./tests/testthat/fixtures/cn_com_fs_security.json"
)

resp_cn_com_fs_insurance <- lxr_cn_com_fs_insurance(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "601318", ,
  metrics_list = "q.ps.oi.t",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fs_insurance,
  "./tests/testthat/fixtures/cn_com_fs_insurance.json"
)

resp_cn_com_fs_other_financial <- lxr_cn_com_fs_other_financial(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "601318", ,
  metrics_list = "q.ps.oi.t",
  .config = list(return_format = "resp")
)

save_json_response(
  resp_cn_com_fs_other_financial,
  "./tests/testthat/fixtures/cn_com_fs_other_financial.json"
)

