resp_hk_com <- lxr_hk_com(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com,
  "./tests/testthat/fixtures/hk_com.json"
)

resp_hk_com_profile <- lxr_hk_com_profile(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_profile,
  "./tests/testthat/fixtures/hk_com_profile.json"
)

resp_hk_com_candlestick <- lxr_hk_com_candlestick(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  type = "lxr_fc_rights",
  start_date = "2025-06-01",
  end_date = "2025-07-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_candlestick,
  "./tests/testthat/fixtures/hk_com_candlestick.json"
)

resp_hk_com_equity_change <- lxr_hk_com_equity_change(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2024-10-01",
  end_date = "2025-10-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_equity_change,
  "./tests/testthat/fixtures/hk_com_equity_change.json"
)

resp_hk_com_employee <- lxr_hk_com_employee(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2024-10-01",
  end_date = "2025-10-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_employee,
  "./tests/testthat/fixtures/hk_com_employee.json"
)

resp_hk_com_repurchase <- lxr_hk_com_repurchase(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2025-09-25",
  end_date = "2025-10-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_repurchase,
  "./tests/testthat/fixtures/hk_com_repurchase.json"
)

resp_hk_com_short_selling <- lxr_hk_com_short_selling(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2025-09-25",
  end_date = "2025-10-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_short_selling,
  "./tests/testthat/fixtures/hk_com_short_selling.json"
)

resp_hk_com_operation_revenue_constitution <- lxr_hk_com_operation_revenue_constitution(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2024-07-01",
  end_date = "2025-07-15",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_operation_revenue_constitution,
  "./tests/testthat/fixtures/hk_com_operation_revenue_constitution.json"
)

resp_hk_com_indices <- lxr_hk_com_indices(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  date = "2025-07-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_indices,
  "./tests/testthat/fixtures/hk_com_indices.json"
)

resp_hk_com_industries <- lxr_hk_com_industries(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_industries,
  "./tests/testthat/fixtures/hk_com_industries.json"
)

resp_hk_com_announcement <- lxr_hk_com_announcement(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2025-09-10",
  end_date = "2025-10-01",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_announcement,
  "./tests/testthat/fixtures/hk_com_announcement.json"
)

resp_hk_com_latest_shareholders <- lxr_hk_com_latest_shareholders(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_latest_shareholders,
  "./tests/testthat/fixtures/hk_com_latest_shareholders.json"
)

resp_hk_com_shareholders_equity_change <- lxr_hk_com_shareholders_equity_change(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2025-01-01",
  end_date = "2025-10-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_shareholders_equity_change,
  "./tests/testthat/fixtures/hk_com_shareholders_equity_change.json"
)

resp_hk_com_fundmtl_non_financial <- lxr_hk_com_fundmtl_non_financial(
  token = Sys.getenv("LIXINGR_TOKEN"),
  date = "2025-07-08",
  stock_codes = "00700",
  metrics_list = c("pe_ttm", "mc", "pe_ttm.y3.cvpos"),
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_fundmtl_non_financial,
  "./tests/testthat/fixtures/hk_com_fundmtl_non_financial.json"
)

resp_hk_com_fs_non_financial <- lxr_hk_com_fs_non_financial(
  token = Sys.getenv("LIXINGR_TOKEN"),
  start_date = "2024-07-01",
  end_date = "2025-07-01",
  stock_codes = "00700", ,
  metrics_list = "q.ps.toi.t",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_fs_non_financial,
  "./tests/testthat/fixtures/hk_com_fs_non_financial.json"
)

resp_hk_com_fund_shareholders <- lxr_hk_com_fund_shareholders(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2024-11-23",
  end_date = "2025-11-23",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_fund_shareholders,
  "./tests/testthat/fixtures/hk_com_fund_shareholders.json"
)

resp_hk_com_fund_collection_shareholders <- lxr_hk_com_fund_collection_shareholders(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2024-11-23",
  end_date = "2025-11-23",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_fund_collection_shareholders,
  "./tests/testthat/fixtures/hk_com_fund_collection_shareholders.json"
)

resp_hk_com_dividend <- lxr_hk_com_dividend(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2024-01-01",
  end_date = "2025-01-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_dividend,
  "./tests/testthat/fixtures/hk_com_dividend.json"
)

resp_hk_com_split <- lxr_hk_com_split(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00700",
  start_date = "2014-01-01",
  end_date = "2014-12-31",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_split,
  "./tests/testthat/fixtures/hk_com_split.json"
)

resp_hk_com_allotment <- lxr_hk_com_allotment(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_code = "00823",
  start_date = "2022-01-01",
  end_date = "2024-01-01",
  limit = 5,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_allotment,
  "./tests/testthat/fixtures/hk_com_allotment.json"
)

resp_hk_com_hot_tr_dri <- lxr_hk_com_hot_tr_dri(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_hot_tr_dri,
  "./tests/testthat/fixtures/hk_com_hot_tr_dri.json"
)

resp_hk_com_hot_mm_ah <- lxr_hk_com_hot_mm_ah(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_hot_mm_ah,
  "./tests/testthat/fixtures/hk_com_hot_mm_ah.json"
)

resp_hk_com_hot_rep <- lxr_hk_com_hot_rep(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_hot_rep,
  "./tests/testthat/fixtures/hk_com_hot_rep.json"
)

resp_hk_com_hot_ss <- lxr_hk_com_hot_ss(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_hot_ss,
  "./tests/testthat/fixtures/hk_com_hot_ss.json"
)

resp_hk_com_hot_director_equity_change <- lxr_hk_com_hot_director_equity_change(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "00700",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_com_hot_director_equity_change,
  "./tests/testthat/fixtures/hk_com_hot_director_equity_change.json"
)
