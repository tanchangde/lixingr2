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
    "options"
  ))
  # token is required (missing arg) but auto-fetched from env if not provided
  expect_true(rlang::is_missing(fmls$token))

  optional_params <- c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted")
  for (param in optional_params) {
    expect_identical(fmls[[param]], rlang::expr(NULL))}
})

test_that("token auto-fetch errors when not set", {
  fn <- make_ep(endpoint = "cn/company", required = "token")
  # Ensure no token is set in environment
  withr::with_envvar(c(LIXINGR_TOKEN = NA), {
    expect_error(fn(), regexp = "API token not found")
  })
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
    req_error = function(req, ...) req,
    resp_status = function(req) 200L,
    req_retry = function(req, max_tries, backoff, ...) {
      for (i in seq_len(max_tries - 1)) {
        backoff(i)
        attempts_seen <<- c(attempts_seen, i)
      }
      req
    },
    .package = "httr2"
  )

  ep(token = "admin", options = list(call_config = list(max_tries = 5L)))

  expect_identical(attempts_seen, 1:4)
})

test_that("send_request handles 400 Bad Request error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      httr2::response(
        status_code = 400L,
        body = charToRaw('{"message": "Invalid input parameters"}')
      )
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Bad Request",
    class = "http_400")
})

test_that("send_request handles 401 Unauthorized error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      httr2::response(
        status_code = 401L,
        body = charToRaw('{"message": "Invalid API key"}')
      )
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Invalid API key",
    class = "http_401")
})

test_that("send_request handles 403 Forbidden error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      httr2::response(
        status_code = 403L,
        body = charToRaw('{"message": "Access denied"}')
      )
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Access denied",
    class = "http_403")
})

test_that("send_request handles 404 Not Found error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      httr2::response(
        status_code = 404L,
        body = charToRaw('{"detail": "Resource not found"}')
      )
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Resource not found",
    class = "http_404")
})

test_that("send_request handles 429 Too Many Requests error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      httr2::response(
        status_code = 429L,
        body = charToRaw('{"message": "Rate limit exceeded"}')
      )
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Rate limit exceeded",
    class = "http_429")
})

test_that("send_request handles 500 Internal Server Error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      httr2::response(
        status_code = 500L,
        body = charToRaw('{"error": "Something went wrong on the server"}')
      )
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Something went wrong on the server",
    class = "http_500")
})
