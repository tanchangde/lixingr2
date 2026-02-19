# Generate test fixtures for cn/index API
# Run: source("data-raw/cn-index-resp.R")

save_resp_as_json <- function(resp, path) {
  resp |>
    httr2::resp_body_json(simplifyVector = TRUE) %>%
    magrittr::use_series("data") |>
    jsonlite::toJSON(auto_unbox = TRUE, pretty = TRUE) |>
    write(path)
}

# Get all index information
resp_cn_index <- lxr_cn_index(
  stock_codes = NULL,
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_index,
  "./tests/testthat/fixtures/cn_index.json"
)

# Get specific index information (000016 = 上证 50)
resp_cn_index_specific <- lxr_cn_index(
  stock_codes = "000016",
  options = list(call_config = list(return_format = "resp"))
)

save_resp_as_json(
  resp_cn_index_specific,
  "./tests/testthat/fixtures/cn_index_specific.json"
)
