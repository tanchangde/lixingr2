source(test_path("helper-mock-lxr-unnest.R"))

test_that("lxr_cn_com converts JSON to data frame correctly", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_resp.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_profile response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_profile.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_equity_change response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_equity_change.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_candlestick response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_candlestick.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_shareholders_num response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_trading_abnormal_resp.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_major_shareholders_shares_change response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_trading_abnormal_resp.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_trading_abnormal response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_senior_executive_shares_change.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})
