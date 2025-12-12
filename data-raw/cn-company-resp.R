save_resp_as_json <- function(resp, path) {
  resp |>
    httr2::resp_body_json(simplifyVector = TRUE) %>%
    magrittr::use_series("data") |>
    jsonlite::toJSON(auto_unbox = TRUE, pretty = TRUE) |>
    write(path)
}

resp_cn_com <- lxr_cn_com(
  stock_codes = c("300750", "600519", "600157"),
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com,
  "./tests/testthat/fixtures/cn_com.json"
)

resp_cn_com_profile <- lxr_cn_com_profile(
  stock_codes = c("300750", "600519", "600579"),
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_profile,
  "./tests/testthat/fixtures/cn_com_profile.json"
)

resp_cn_com_equity_change <- lxr_cn_com_equity_change(
  stock_code = "300750",
  start_date = "2024-10-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_equity_change,
  "./tests/testthat/fixtures/cn_com_equity_change.json"
)

resp_cn_com_candlestick <- lxr_cn_com_candlestick(
  stock_code = "300750",
  type = "ex_rights",
  start_date = "2025-06-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_candlestick,
  "./tests/testthat/fixtures/cn_com_candlestick.json"
)

resp_cn_com_shareholders_num <- lxr_cn_com_shareholders_num(
  stock_code = "300750",
  start_date = "2024-06-01",
  end_date = "2025-07-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_shareholders_num,
  "./tests/testthat/fixtures/cn_com_shareholders_num.json"
)

resp_cn_com_senior_executive_shares_change <-
  lxr_cn_com_senior_executive_shares_change(
    stock_code = "300750",
    start_date = "2020-07-08",
    end_date = "2025-07-01",
    limit = 5,
    options = list(call_config = list(return_format = "resp"))
  )

save_resp_as_json(
  resp_cn_com_senior_executive_shares_change,
  "./tests/testthat/fixtures/cn_com_senior_executive_shares_change.json"
)

resp_cn_com_major_shareholders_shares_change <-
  lxr_cn_com_major_shareholders_shares_change(
    stock_code = "300750",
    start_date = "2015-07-01",
    end_date = "2025-07-01",
    limit = 5,
    options = list(call_config = list(return_format = "resp"))
  )

save_resp_as_json(
  resp_cn_com_major_shareholders_shares_change,
  "./tests/testthat/fixtures/cn_com_major_shareholders_shares_change.json"
)

resp_cn_com_trading_abnormal <- lxr_cn_com_trading_abnormal(
  start_date = "2020-03-01",
  end_date = "2025-07-01",
  stock_code = "300750",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_trading_abnormal,
  "./tests/testthat/fixtures/cn_com_trading_abnormal.json"
)

resp_cn_com_block_deal <- lxr_cn_com_block_deal(
  stock_code = "300750",
  start_date = "2015-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_block_deal,
  "./tests/testthat/fixtures/cn_com_block_deal.json"
)

resp_cn_com_pledge <- lxr_cn_com_pledge(
  stock_code = "300750",
  start_date = "2022-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_pledge,
  "./tests/testthat/fixtures/cn_com_pledge.json"
)

resp_cn_com_operation_revenue_constitution <- lxr_cn_com_operation_revenue_constitution(
  stock_code = "300750",
  start_date = "2023-07-01",
  end_date = "2025-07-15",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_operation_revenue_constitution,
  "./tests/testthat/fixtures/cn_com_operation_revenue_constitution.json"
)

resp_cn_com_operating_data <- lxr_cn_com_operating_data(
  stock_code = "600519",
  start_date = "2023-07-01",
  end_date = "2025-07-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_operating_data,
  "./tests/testthat/fixtures/cn_com_operating_data.json"
)

resp_cn_com_indices <- lxr_cn_com_indices(
  stock_code = "600900",
  date = "2023-07-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_indices,
  "./tests/testthat/fixtures/cn_com_indices.json"
)

resp_cn_com_industries <- lxr_cn_com_industries(
  stock_code = "300750",
  date = "2025-07-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_industries,
  "./tests/testthat/fixtures/cn_com_industries.json"
)

resp_cn_com_announcement <- lxr_cn_com_announcement(
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-15",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_announcement,
  "./tests/testthat/fixtures/cn_com_announcement.json"
)

resp_cn_com_measures <- lxr_cn_com_measures(
  stock_code = "600866",
  start_date = "2016-07-01",
  end_date = "2025-07-15",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_measures,
  "./tests/testthat/fixtures/cn_com_measures.json"
)

resp_cn_com_inquiry <- lxr_cn_com_inquiry(
  stock_code = "600866",
  start_date = "2015-07-15",
  end_date = "2025-07-15",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_inquiry,
  "./tests/testthat/fixtures/cn_com_inquiry.json"
)

resp_cn_com_majority_shareholders <- lxr_cn_com_majority_shareholders(
  stock_code = "300750",
  start_date = "2024-07-15",
  end_date = "2025-07-15",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_majority_shareholders,
  "./tests/testthat/fixtures/cn_com_majority_shareholders.json"
)

resp_cn_com_nolimit_shareholders <- lxr_cn_com_nolimit_shareholders(
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_nolimit_shareholders,
  "./tests/testthat/fixtures/cn_com_nolimit_shareholders.json"
)

resp_cn_com_fund_shareholders <- lxr_cn_com_fund_shareholders(
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fund_shareholders,
  "./tests/testthat/fixtures/cn_com_fund_shareholders.json"
)

resp_cn_com_fund_collection_shareholders <- lxr_cn_com_fund_collection_shareholders(
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fund_collection_shareholders,
  "./tests/testthat/fixtures/cn_com_fund_collection_shareholders.json"
)

resp_cn_com_dividend <- lxr_cn_com_dividend(
  stock_code = "300750",
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_dividend,
  "./tests/testthat/fixtures/cn_com_dividend.json"
)

resp_cn_com_allotment <- lxr_cn_com_allotment(
  stock_code = "600958",
  start_date = "2015-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_allotment,
  "./tests/testthat/fixtures/cn_com_allotment.json"
)

resp_cn_com_customers <- lxr_cn_com_customers(
  stock_code = "300750",
  start_date = "2023-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_customers,
  "./tests/testthat/fixtures/cn_com_customers.json"
)

resp_cn_com_suppliers <- lxr_cn_com_suppliers(
  stock_code = "300750",
  start_date = "2023-07-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_suppliers,
  "./tests/testthat/fixtures/cn_com_suppliers.json"
)

resp_cn_com_fundmtl_non_financial <- lxr_cn_com_fundmtl_non_financial(
  date = "2025-07-08",
  stock_codes = c("300750", "600519", "600157"),
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y3.cvpos"),
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fundmtl_non_financial,
  "./tests/testthat/fixtures/cn_com_fundmtl_non_financial.json"
)

resp_cn_com_fundmtl_bank <- lxr_cn_com_fundmtl_bank(
  start_date = "2025-07-01",
  end_date = "2025-07-08",
  stock_codes = "600036", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fundmtl_bank,
  "./tests/testthat/fixtures/cn_com_fundmtl_bank.json"
)

resp_cn_com_fundmtl_security <- lxr_cn_com_fundmtl_security(
  start_date = "2025-07-01",
  end_date = "2025-07-15",
  stock_codes = "600030", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fundmtl_security,
  "./tests/testthat/fixtures/cn_com_fundmtl_security.json"
)

resp_cn_com_fundmtl_insurance <- lxr_cn_com_fundmtl_insurance(
  start_date = "2025-07-01",
  end_date = "2025-07-15",
  stock_codes = "601318", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fundmtl_insurance,
  "./tests/testthat/fixtures/cn_com_fundmtl_insurance.json"
)

resp_cn_com_fundmtl_other_financial <- lxr_cn_com_fundmtl_other_financial(
  start_date = "2025-07-01",
  end_date = "2025-07-15",
  stock_codes = "600901", ,
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos"),
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fundmtl_other_financial,
  "./tests/testthat/fixtures/cn_com_fundmtl_other_financial.json"
)

resp_cn_com_fs_non_financial <- lxr_cn_com_fs_non_financial(
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  stock_codes = "300750", ,
  metrics_list = "q.ps.toi.t",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fs_non_financial,
  "./tests/testthat/fixtures/cn_com_fs_non_financial.json"
)

resp_cn_com_fs_bank <- lxr_cn_com_fs_bank(
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "300750", ,
  metrics_list = "q.ps.oi.t",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fs_bank,
  "./tests/testthat/fixtures/cn_com_fs_bank.json"
)

resp_cn_com_fs_security <- lxr_cn_com_fs_security(
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "300750", ,
  metrics_list = "q.ps.oi.t",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fs_security,
  "./tests/testthat/fixtures/cn_com_fs_security.json"
)

resp_cn_com_fs_insurance <- lxr_cn_com_fs_insurance(
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "601318", ,
  metrics_list = "q.ps.oi.t",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fs_insurance,
  "./tests/testthat/fixtures/cn_com_fs_insurance.json"
)

resp_cn_com_fs_other_financial <- lxr_cn_com_fs_other_financial(
  start_date = "2024-03-31",
  end_date = "2025-03-31",
  stock_codes = "601318", ,
  metrics_list = "q.ps.oi.t",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_com_fs_other_financial,
  "./tests/testthat/fixtures/cn_com_fs_other_financial.json"
)
