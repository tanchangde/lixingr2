source(test_path("helper-mock-lxr-unnest.R"))

test_that("hk_com_dividend response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_dividend.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})
