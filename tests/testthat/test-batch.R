# ── lxr_batch tests ──────────────────────────────────────────────────────────

test_that("lxr_batch validates stock_codes parameter", {
  mock_fn <- function(stock_codes, ...) tibble::tibble(code = stock_codes)

  # Empty vector should error
  expect_error(
    lxr_batch(stock_codes = character(0), fn = mock_fn),
    "must be a non-empty character vector"
  )

  # Non-character should error
  expect_error(
    lxr_batch(stock_codes = 123, fn = mock_fn),
    "must be a non-empty character vector"
  )

# NULL should error
  expect_error(
    lxr_batch(stock_codes = NULL, fn = mock_fn),
    "must be a non-empty character vector"
  )
})

test_that("lxr_batch validates fn parameter", {
  expect_error(
    lxr_batch(stock_codes = "600519", fn = "not_a_function"),
    "must be a function"
  )

  expect_error(
    lxr_batch(stock_codes = "600519", fn = 123),
    "must be a function"
  )
})

test_that("lxr_batch forces tibble return format", {
  mock_fn <- function(stock_codes, options, ...) {
    # Return the options to verify tibble was forced
    list(
      result = tibble::tibble(code = stock_codes),
      received_format = options$call_config$return_format
    )
  }

  # Even if user passes different format, it should be overridden
  result <- lxr_batch(
    stock_codes = "600519",
    fn = mock_fn,
    options = list(call_config = list(return_format = "json")),
    .progress = FALSE
  )

  # The mock returns list with result and received_format
  # Since we forced tibble, the inner fn receives tibble
  expect_equal(result$received_format, "tibble")
})

test_that("lxr_batch returns single batch without splitting", {
  call_count <- 0
  mock_fn <- function(stock_codes, ...) {
    call_count <<- call_count + 1
    tibble::tibble(code = stock_codes, value = seq_along(stock_codes))
  }

  codes <- c("600519", "000001", "000002")
  result <- lxr_batch(
    stock_codes = codes,
    fn = mock_fn,
    batch_size = 100,
    .progress = FALSE
  )

  expect_equal(call_count, 1)
  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 3)
  expect_equal(result$code, codes)
})

test_that("lxr_batch splits large requests into batches", {
  call_count <- 0
  received_codes <- list()

  mock_fn <- function(stock_codes, ...) {
    call_count <<- call_count + 1
    received_codes[[call_count]] <<- stock_codes
    tibble::tibble(code = stock_codes, batch = call_count)
  }

  codes <- sprintf("%06d", 1:250)
  result <- lxr_batch(
    stock_codes = codes,
    fn = mock_fn,
    batch_size = 100,
    delay = 0,
    .progress = FALSE
  )

  # Should split into 3 batches: 100 + 100 + 50
  expect_equal(call_count, 3)
  expect_equal(length(received_codes[[1]]), 100)
  expect_equal(length(received_codes[[2]]), 100)
  expect_equal(length(received_codes[[3]]), 50)

  # Combined result should have all 250 rows
  expect_equal(nrow(result), 250)
})

test_that("lxr_batch passes extra arguments to fn", {
  received_args <- NULL

  mock_fn <- function(stock_codes, token, custom_param, ...) {
    received_args <<- list(
      stock_codes = stock_codes,
      token = token,
      custom_param = custom_param
    )
    tibble::tibble(code = stock_codes)
  }

  lxr_batch(
    stock_codes = "600519",
    fn = mock_fn,
    token = "test_token",
    custom_param = "custom_value",
    .progress = FALSE
  )

  expect_equal(received_args$token, "test_token")
  expect_equal(received_args$custom_param, "custom_value")
})

test_that("lxr_batch handles partial batch failures gracefully", {
  call_count <- 0

  mock_fn <- function(stock_codes, ...) {
    call_count <<- call_count + 1
    if (call_count == 2) {
      stop("Simulated API error")
    }
    tibble::tibble(code = stock_codes, batch = call_count)
  }

  codes <- sprintf("%06d", 1:30)

  # Should warn but not error when some batches fail
  expect_warning(
    result <- lxr_batch(
      stock_codes = codes,
      fn = mock_fn,
      batch_size = 10,
      delay = 0,
      max_retries = 0,  # No retries to speed up test
      .progress = FALSE
    ),
    "Batch 2 failed"
  )

  # Should still return results from successful batches
  expect_equal(nrow(result), 20)  # 30 - 10 failed
})

test_that("lxr_batch retries failed batches", {
  attempt_count <- 0

  mock_fn <- function(stock_codes, ...) {
    attempt_count <<- attempt_count + 1
    if (attempt_count < 3) {
      stop("Transient error")
    }
    tibble::tibble(code = stock_codes)
  }

  # Use multiple codes with small batch_size to trigger multi-batch path
  # (single batch uses fast path without retry logic)
  codes <- sprintf("%06d", 1:5)

  # Should succeed after retries
  result <- suppressWarnings(
    lxr_batch(
      stock_codes = codes,
      fn = mock_fn,
      batch_size = 2,  # Creates 3 batches: 2+2+1
      max_retries = 3,
      delay = 0,
      .progress = FALSE
    )
  )

  expect_s3_class(result, "tbl_df")
  expect_gte(attempt_count, 3)
})

test_that("lxr_batch errors when all batches fail", {
  mock_fn <- function(stock_codes, ...) {
    stop("All requests fail")
  }

  expect_error(
    suppressWarnings(
      lxr_batch(
        stock_codes = sprintf("%06d", 1:20),
        fn = mock_fn,
        batch_size = 10,
        max_retries = 0,
        delay = 0,
        .progress = FALSE
      )
    ),
    "All .* batches failed"
  )
})

test_that("lxr_batch respects batch_size parameter", {
  batch_sizes <- integer(0)

  mock_fn <- function(stock_codes, ...) {
    batch_sizes <<- c(batch_sizes, length(stock_codes))
    tibble::tibble(code = stock_codes)
  }

  codes <- sprintf("%06d", 1:75)
  lxr_batch(
    stock_codes = codes,
    fn = mock_fn,
    batch_size = 25,
    delay = 0,
    .progress = FALSE
  )

  expect_equal(batch_sizes, c(25, 25, 25))
})
