source(test_path("helper-mock-lxr-unnest.R"))

test_that("hk_com_dividend response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_dividend.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_split response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_split.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_split response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_split.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_allotment response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_allotment.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_tr_dri response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_tr_dri.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_mm_ah response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_mm_ah.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_rep response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_rep.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_ss response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_ss.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_director_equity_change response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_director_equity_change.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_npd response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_npd.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_capita response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_capita.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

test_that("hk_com_hot_tr response is correctly converted to a data frame", {
  result <- mock_lxr_unnest(test_path("fixtures", "hk_com_hot_tr.json"))

  expect_true(is.data.frame(result))
  expect_true(all(purrr::map_lgl(result, ~ !is.list(.))))
})

