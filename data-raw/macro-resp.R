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

resp_macro_national_debt <- lxr_macro_national_debt(
  token = Sys.getenv("LIXINGR_TOKEN"),
  area_code = "us",
  start_date = "2025-09-01",
  end_date = "2025-09-06",
  metrics_list = "tcm_y1",
  options = list(call_config = list(return_format = "resp"))
)

save_json_response(
  resp_macro_national_debt,
  "./tests/testthat/fixtures/resp_macro_national_debt.json"
)

resp_macro_interest_rates <- lxr_macro_interest_rates(
  token = Sys.getenv("LIXINGR_TOKEN"),
  area_code = "cn",
  start_date = "2025-09-01",
  end_date = "2025-09-06",
  metrics_list = "cdnaaa_y1",
  options = list(call_config = list(return_format = "resp"))
)

save_json_response(
  resp_macro_interest_rates,
  "./tests/testthat/fixtures/resp_macro_interest_rates.json"
)
