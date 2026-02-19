source(test_path("helper-mock-lxr-unnest.R"))

test_that("cn_index response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_index.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("cn_index_specific response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "cn_index_specific.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))

  # Check specific index data structure
  expect_equal(result$stockCode, "000016")
  expect_equal(result$areaCode, "cn")
  expect_equal(result$market, "a")
  expect_equal(result$source, "csi")
  expect_equal(result$currency, "CNY")
  expect_equal(result$series, "size")
  expect_equal(result$launchDate, "2004-01-02T00:00:00+08:00")
  expect_equal(result$rebalancingFrequency, "semi-annually")
  expect_equal(result$caculationMethod, "grading_weighted")
  expect_equal(result$fsTableType, "hybrid")
})
