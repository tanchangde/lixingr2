  mock_lxr_unnest <- function(path) {
    readLines(path) |>
    jsonlite::fromJSON(flatten = TRUE) |>
      lxr_unnest()
  }
