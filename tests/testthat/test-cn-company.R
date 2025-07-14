source(test_path("helper-mock-lxr-unnest.R"))

test_that("lxr_cn_com converts JSON to data frame correctly", {
  mock_lxr_cn_com <- function() {
    json_data <- readLines(test_path("fixtures", "cn_com_resp.json"))

    json_data |>
    jsonlite::fromJSON(flatten = TRUE) |>
      lxr_unnest()
  }

  result <- mock_lxr_cn_com()
  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_trading_abnormal response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_trading_abnormal_resp.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})
