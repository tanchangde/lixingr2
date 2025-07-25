make_ep <- getFromNamespace("make_endpoint", "lixingr2")

test_that("generated function has correct formals", {
  fn <- make_ep(
    endpoint = "cn/company",
    required = "token",
    optional = c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted")
    )
  fmls <- formals(fn)
  expect_setequal(names(fmls), c(
    "token", "stock_codes", "fs_table_type", "mutual_markets", "include_delisted",
    ".hdrs", ".config"
  ))
  expect_true(rlang::is_missing(fmls$token))

  optional_params <- c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted")
  for (param in optional_params) {
    expect_identical(fmls[[param]], rlang::expr(NULL))}
  })

test_that("required parameters are enforced", {
  fn <- make_ep(endpoint = "cn/company", required = "token")
  expect_error(fn(), regexp = "`token` is absent")
})

test_that("parameter cleaning & camelCase conversion works", {
  captured <- NULL
  local_mocked_bindings(
    req_perform = function(req, ...) {
      captured <<- req
      httr2::response(
        url         = "https://dummy/",
        status_code = 200,
        headers     = list("Content-Type" = "application/json"),
        body        = charToRaw('{"ok": true}')
      )
    },
    .package = "httr2"
  )

  fn <- make_ep(
    endpoint = "cn/company",
    required = c("token", "stock_codes"),
    optional = c("adjust_forward_date", "metrics_list")
  )

  fn(
    token = "admin",
    stock_codes = c("300750", "600519", "600157"),
    adjust_forward_date = "2023-01-01",
    metrics_list = c("mc", "pe_ttm", "pb", "dyr")
  )

  body <- captured$body$data

  expect_named(body, c("token", "stockCodes", "adjustForwardDate", "metricsList"),
    ignore.order = TRUE
  )
  expect_true(inherits(body$token, "scalar"))
  expect_true(inherits(body$adjustForwardDate, "scalar"))
  expect_identical(body$stockCodes, c("300750", "600519", "600157"))
  expect_identical(body$metricsList, c("mc", "pe_ttm", "pb", "dyr"))
})

test_that("NULL parameters and internal parameters are excluded", {
  captured <- NULL
  local_mocked_bindings(
    req_perform = function(req, ...) {
      captured <<- req
      httr2::response(
        url         = "https://dummy/",
        status_code = 200,
        headers     = list("Content-Type" = "application/json"),
        body        = charToRaw('{"ok": true}')
      )
    },
    .package = "httr2"
  )

  fn <- make_ep(
    endpoint = "cn/company",
    required = "token",
    optional = c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted"))
  fn(token = "admin", stock_codes = NULL)

  body <- captured$body$data
  expect_false("stock_codes" %in% names(body))
  expect_false(any(grepl("^\\.", names(body))))
})

test_that("backoff_fun receives correct attempt numbers", {
  ep <- make_endpoint(
    endpoint = "cn/company",
    required = "token",
  )

  attempts_seen <- integer()

  local_mocked_bindings(
    request = function(...) list(),
    req_headers = function(req, ...) req,
    req_url_path_append = function(req, ...) req,
    req_perform = function(req, ...) list(status = 200L),
    req_body_json = function(req, ...) req,
    resp_body_string = function(req, ...) req,
    resp_body_json = function(req, ...) req,
    req_retry = function(req, max_tries, backoff, ...) {
      for (i in seq_len(max_tries - 1)) {
        backoff(i)
        attempts_seen <<- c(attempts_seen, i)
      }
      req
    },
    .package = "httr2"
  )

  ep(token = "admin", .config = list(max_tries = 5L))

  expect_identical(attempts_seen, 1:4)
})
