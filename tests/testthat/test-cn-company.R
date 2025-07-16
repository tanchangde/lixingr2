source(test_path("helper-mock-lxr-unnest.R"))

test_that("cn_com response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com.json"))

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
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_shareholders_num.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_senior_executive_shares_change response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_senior_executive_shares_change.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_major_shareholders_shares_change response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_major_shareholders_shares_change.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_trading_abnormal response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_trading_abnormal.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_block_deal response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_block_deal.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_pledge response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_pledge.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_operation_revenue_constitution response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_operation_revenue_constitution.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_indices response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_indices.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_industries response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_industries.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_announcement response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_announcement.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_measures response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_measures.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_inquiry response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_inquiry.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_majority_shareholders response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_majority_shareholders.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_nolimit_shareholders response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_nolimit_shareholders.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_fund_shareholders response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_fund_shareholders.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_com_fund_collection_shareholders response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_com_fund_collection_shareholders.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})
