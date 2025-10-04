if (getRversion() >= "2.15.1") {
  utils::globalVariables(
    c(".data", "%||%")
  )
}

save_resp_as_json <- function(resp, path) {
  resp |>
    httr2::resp_body_json(simplifyVector = TRUE) |>
    magrittr::use_series("data") |>
    jsonlite::toJSON(auto_unbox = TRUE, pretty = TRUE) |>
    write(path)
}
