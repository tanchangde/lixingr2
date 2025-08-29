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
