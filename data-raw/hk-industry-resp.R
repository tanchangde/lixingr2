resp_hk_industry <- lxr_hk_industry(
  token = Sys.getenv("LIXINGR_TOKEN"),
  stock_codes = "H50",
  source = "hsi",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_hk_industry,
  "./tests/testthat/fixtures/hk_industry.json"
)
