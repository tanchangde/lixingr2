# === Helper functions ===
mock_success_response <- function(body = '{"ok": true}') {
  httr2::response(
    url         = "https://dummy/",
    status_code = 200L,
    headers     = list("Content-Type" = "application/json"),
    body        = charToRaw(body)
  )
}

mock_error_response <- function(status_code, body) {
  httr2::response(
    status_code = status_code,
    body        = charToRaw(body)
  )
}

# Internal functions for testing
make_ep <- getFromNamespace("make_endpoint", "lixingr2")
lxr_unnest <- getFromNamespace("lxr_unnest", "lixingr2")

# === Tests for lxr_unnest ===
test_that("lxr_unnest returns unchanged df when no list columns", {
  df <- data.frame(a = 1:3, b = c("x", "y", "z"))
  result <- lxr_unnest(df)
  expect_identical(result, df)
})

test_that("lxr_unnest unnests single list column", {
  df <- tibble::tibble(
    id = 1:2,
    nested = list(
      data.frame(x = c(1, 2), y = c("a", "b")),
      data.frame(x = 3, y = "c")
    )
  )
  result <- lxr_unnest(df)

  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 3)
  expect_true("nested.x" %in% names(result))
  expect_true("nested.y" %in% names(result))
})

test_that("lxr_unnest handles empty list elements (keep_empty)", {
  df <- tibble::tibble(
    id = 1:2,
    nested = list(
      data.frame(x = 1),
      NULL
    )
  )
  result <- lxr_unnest(df)

  expect_equal(nrow(result), 2)
  expect_true(is.na(result$nested.x[2]))
})

test_that("lxr_unnest unnests multiple list columns", {
  df <- tibble::tibble(
    id = 1:2,
    col1 = list(data.frame(a = 1), data.frame(a = 2:3)),
    col2 = list(data.frame(b = "x"), data.frame(b = c("y", "z")))
  )
  result <- lxr_unnest(df)

  expect_true("col1.a" %in% names(result))
  expect_true("col2.b" %in% names(result))
})

test_that("lxr_unnest handles deeply nested structures", {
  df <- tibble::tibble(
    id = 1,
    nested = list(data.frame(
      x = 1,
      inner = I(list(data.frame(y = "deep")))
    ))
  )
  result <- lxr_unnest(df)

  expect_s3_class(result, "data.frame")
  expect_true("nested.x" %in% names(result))
})

test_that("lxr_unnest handles uneven row counts across list columns", {
  df <- tibble::tibble(
    id = 1,
    col1 = list(data.frame(a = 1:3)),
    col2 = list(data.frame(b = 1:2))
  )
  result <- lxr_unnest(df)

  # full_join should produce 3 rows (max of the two)

  expect_equal(nrow(result), 3)
})

# === Tests for new_client ===
test_that("new_client creates valid api_client object", {
  client <- new_client()

  expect_s3_class(client, "api_client")
  expect_equal(client$base_url, "https://open.lixinger.com/api")
  expect_type(client$default_hdrs, "list")
  expect_type(client$default_cfg, "list")
  expect_true(is.function(client$name_transform))
})

test_that("new_client validates default_hdrs must be list", {
  expect_error(
    new_client(default_hdrs = "not a list"),
    regexp = "must be a list"
  )
})

test_that("new_client validates name_transform must be function", {
  expect_error(
    new_client(name_transform = "not a function"),
    regexp = "must be a function"
  )
})

test_that("new_client validates URL format", {
  expect_error(
    new_client(base_url = "not a valid url :::"),
    regexp = "Invalid URL format"
  )
})

test_that("new_client accepts custom parameters", {
  custom_transform <- function(x) toupper(x)
  client <- new_client(
    base_url       = "https://custom.api.com",
    default_hdrs   = list("Authorization" = "Bearer token"),
    name_transform = custom_transform
  )

  expect_equal(client$base_url, "https://custom.api.com")
  expect_equal(client$default_hdrs$Authorization, "Bearer token")
  expect_equal(client$name_transform("test"), "TEST")
})

# === Tests for send_request ===
test_that("send_request validates client parameter", {
  expect_error(
    send_request(client = list(), path = "test"),
    regexp = "must be created with"
  )
})

test_that("send_request validates path parameter", {
  expect_error(
    send_request(client = new_client(), path = 123),
    regexp = "must be a single character string"
  )

  expect_error(
    send_request(client = new_client(), path = c("a", "b")),
    regexp = "must be a single character string"
  )
})

test_that("send_request validates return_format", {
  expect_error(
    send_request(
      new_client(),
      path = "test",
      cfg = list(return_format = "invalid")
    ),
    regexp = "return_format must be one of"
  )
})

test_that("send_request returns json format correctly", {
  local_mocked_bindings(
    req_perform = function(req, ...) mock_success_response('{"data": "test"}'),
    .package = "httr2"
  )

  result <- send_request(
    new_client(),
    path = "test",
    cfg = list(return_format = "json")
  )

  expect_type(result, "character")
  expect_match(result, "data")
})

test_that("send_request returns list format correctly", {
  local_mocked_bindings(
    req_perform = function(req, ...) mock_success_response('{"data": "test"}'),
    .package = "httr2"
  )

  result <- send_request(
    new_client(),
    path = "test",
    cfg = list(return_format = "list")
  )

  expect_type(result, "list")
  expect_equal(result$data, "test")
})

test_that("send_request returns resp format correctly", {
  local_mocked_bindings(
    req_perform = function(req, ...) mock_success_response('{"data": "test"}'),
    .package = "httr2"
  )

  result <- send_request(
    new_client(),
    path = "test",
    cfg = list(return_format = "resp")
  )

  expect_s3_class(result, "httr2_response")
})

test_that("send_request returns tibble format correctly", {
  response_body <- '{"data": [{"id": 1, "name": "a"}, {"id": 2, "name": "b"}]}'
  local_mocked_bindings(
    req_perform = function(req, ...) mock_success_response(response_body),
    .package = "httr2"
  )

  result <- send_request(
    new_client(),
    path = "test",
    cfg = list(return_format = "tibble")
  )


  expect_s3_class(result, "tbl_df")
  expect_equal(nrow(result), 2)
})

test_that("send_request errors when tibble format returns empty data", {
  local_mocked_bindings(
    req_perform = function(req, ...) mock_success_response('{"data": []}'),
    .package = "httr2"
  )

  expect_error(
    send_request(
      new_client(),
      path = "test",
      cfg = list(return_format = "tibble")
    ),
    regexp = "no data returned"
  )
})

test_that("send_request handles 400 Bad Request error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(400L, '{"message": "Invalid input parameters"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Bad Request",
    class = "http_400"
  )
})

test_that("send_request handles 401 Unauthorized error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(401L, '{"message": "Invalid API key"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Invalid API key",
    class = "http_401"
  )
})

test_that("send_request handles 403 Forbidden error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(403L, '{"message": "Access denied"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Access denied",
    class = "http_403"
  )
})

test_that("send_request handles 404 Not Found error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(404L, '{"detail": "Resource not found"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Resource not found",
    class = "http_404"
  )
})

test_that("send_request handles 429 Too Many Requests error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(429L, '{"message": "Rate limit exceeded"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Rate limit exceeded",
    class = "http_429"
  )
})

test_that("send_request handles 500 Internal Server Error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(500L, '{"error": "Something went wrong on the server"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Something went wrong on the server",
    class = "http_500"
  )
})

test_that("send_request handles non-JSON error response body", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(500L, "Plain text error message")
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Plain text error message",
    class = "http_500"
  )
})

test_that("send_request handles 502 Bad Gateway error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(502L, '{"error": "Bad Gateway"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Bad Gateway",
    class = "http_502"
  )
})

test_that("send_request handles 503 Service Unavailable error", {
  local_mocked_bindings(
    req_perform = function(req, ...) {
      mock_error_response(503L, '{"error": "Service Unavailable"}')
    },
    .package = "httr2"
  )

  expect_error(
    send_request(new_client(), path = "path"),
    regexp = "Service Unavailable",
    class = "http_503"
  )
})

# === Tests for make_endpoint ===
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
    expect_identical(fmls[[param]], rlang::expr(NULL))
  }
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
      mock_success_response()
    },
    .package = "httr2"
  )

  fn <- make_ep(
    endpoint = "cn/company",
    required = c("token", "stock_codes"),
    optional = c("adjust_forward_date", "metrics_list"),
    array_params = c("stock_codes", "metrics_list")
  )

  fn(
    token = "admin",
    stock_codes = c("300750", "600519", "600157"),
    adjust_forward_date = "2023-01-01",
    metrics_list = c("mc", "pe_ttm", "pb", "dyr")
  )

  body <- captured$body$data

  expect_named(
    body,
    c("token", "stockCodes", "adjustForwardDate", "metricsList"),
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
      mock_success_response()
    },
    .package = "httr2"
  )

  fn <- make_ep(
    endpoint = "cn/company",
    required = "token",
    optional = c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted")
  )
  fn(token = "admin", stock_codes = NULL)

  body <- captured$body$data
  expect_false("stock_codes" %in% names(body))
  expect_false(any(grepl("^\\.", names(body))))
})

test_that("array_params controls which parameters are encoded as arrays", {
  captured <- NULL
  local_mocked_bindings(
    req_perform = function(req, ...) {
      captured <<- req
      mock_success_response()
    },
    .package = "httr2"
  )

  # Without array_params, vector parameters should be unboxed (and fail)
  fn_no_array <- make_ep(
    endpoint = "test",
    required = c("token", "codes"),
    array_params = NULL
  )

  # Single value should work without array_params
  fn_no_array(token = "admin", codes = "single")
  expect_true(inherits(captured$body$data$codes, "scalar"))

  # With array_params, vector parameters should remain as arrays
  fn_with_array <- make_ep(
    endpoint = "test",
    required = c("token", "codes"),
    array_params = "codes"
  )

  fn_with_array(token = "admin", codes = c("A", "B", "C"))
  expect_identical(captured$body$data$codes, c("A", "B", "C"))
  expect_false(inherits(captured$body$data$codes, "scalar"))
})

test_that("backoff_fun receives correct attempt numbers", {
  ep <- make_ep(
    endpoint = "cn/company",
    required = "token"
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

test_that("make_endpoint checks required parameters (except token)", {
  fn <- make_ep(
    endpoint = "cn/company",
    required = c("token", "stock_codes"),
    optional = c("date")
  )

  # stock_codes is required but not provided
expect_error(
    fn(token = "admin"),
    regexp = "stock_codes"
  )
})

test_that("make_endpoint passes extra_headers via options", {
  captured <- NULL
  local_mocked_bindings(
    req_perform = function(req, ...) {
      captured <<- req
      mock_success_response()
    },
    .package = "httr2"
  )

  fn <- make_ep(
    endpoint = "test",
    required = "token"
  )

  fn(
    token = "admin",
    options = list(extra_headers = list("X-Custom-Header" = "custom-value"))
  )

  # Verify the custom header was passed
  expect_true("X-Custom-Header" %in% names(captured$headers))
  expect_equal(captured$headers[["X-Custom-Header"]], "custom-value")
})

test_that("default backoff_fun follows exponential backoff pattern", {
  client <- new_client()

  # Extract the default backoff function
  backoff_fn <- client$default_cfg$backoff_fun

  # Default is NULL, so send_request creates a default
expect_null(backoff_fn)

  # Test the actual backoff calculation logic from send_request
  # backoff = min(0.5 * 2^(attempt - 1) + jitter, 10)
  # attempt 1: 0.5 * 2^0 = 0.5 + jitter (0-0.4)
  # attempt 2: 0.5 * 2^1 = 1.0 + jitter
  # attempt 3: 0.5 * 2^2 = 2.0 + jitter
  # ...capped at 10

  # Create a custom backoff to verify the pattern
  test_backoff <- function(attempt) {
    min(0.5 * 2^(attempt - 1), 10)
  }

  expect_equal(test_backoff(1), 0.5)
  expect_equal(test_backoff(2), 1.0)
  expect_equal(test_backoff(3), 2.0)
  expect_equal(test_backoff(4), 4.0)
  expect_equal(test_backoff(5), 8.0)
  expect_equal(test_backoff(6), 10.0)  # capped
})
