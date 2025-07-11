make_ep <- getFromNamespace("make_endpoint", "lixingr2")

test_that("generated function has correct formals", {
  fn <- make_ep("dummy", required = c("foo", "bar"), optional = c("opt_x"))
  fmls <- formals(fn)
  expect_setequal(names(fmls), c("foo", "bar", "opt_x"))
  expect_true(rlang::is_missing(fmls$foo))
  expect_true(rlang::is_missing(fmls$bar))
  expect_identical(fmls$opt_x, rlang::expr(NULL))
})

test_that("required parameters are enforced", {
  fn <- make_ep("dummy", required = "foo")
  expect_error(fn(), regexp = "`foo` is absent")
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
    "test/path",
    required = c("foo_val"),
    optional = c("bar_baz", "stockCodes")
  )

  fn(
    foo_val     = 123,
    bar_baz     = "abc",
    stockCodes  = c("AAA", "BBB")
  )

  body <- captured$body$data
  expect_named(body, c("fooVal", "barBaz", "stockCodes"), ignore.order = TRUE)
  expect_true(inherits(body$fooVal, "scalar"))
  expect_true(inherits(body$barBaz, "scalar"))
  expect_identical(body$stockCodes, c("AAA", "BBB"))
})

test_that("NULL optional parameters are dropped", {
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

  fn <- make_ep("dummy", required = "foo", optional = c("opt"))
  fn(foo = 1, opt = NULL)

  body <- captured$body$data
  expect_false("opt" %in% names(body))
})
