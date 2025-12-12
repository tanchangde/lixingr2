test_that("lxr_set_token stores token in environment", {
  withr::with_envvar(c(LIXINGR_TOKEN = NA), {
    expect_message(lxr_set_token("test-token"), "Token set successfully")
    expect_equal(Sys.getenv("LIXINGR_TOKEN"), "test-token")
  })
})

test_that("lxr_set_token validates input", {
  expect_error(lxr_set_token(123), "non-empty character string")
  expect_error(lxr_set_token(""), "non-empty character string")
  expect_error(lxr_set_token(c("a", "b")), "non-empty character string")
  expect_error(lxr_set_token(NULL), "non-empty character string")
})

test_that("lxr_get_token retrieves token from environment", {
  withr::with_envvar(c(LIXINGR_TOKEN = "my-secret-token"), {
    expect_equal(lxr_get_token(), "my-secret-token")
  })
})

test_that("lxr_get_token errors when token not set", {
  withr::with_envvar(c(LIXINGR_TOKEN = NA), {
    expect_error(lxr_get_token(), "API token not found")
  })
})

test_that("lxr_get_token errors when token is empty string", {
  withr::with_envvar(c(LIXINGR_TOKEN = ""), {
    expect_error(lxr_get_token(), "API token not found")
  })
})

test_that("lxr_has_token returns TRUE when token is set", {
  withr::with_envvar(c(LIXINGR_TOKEN = "some-token"), {
    expect_true(lxr_has_token())
  })
})

test_that("lxr_has_token returns FALSE when token is not set", {
  withr::with_envvar(c(LIXINGR_TOKEN = NA), {
    expect_false(lxr_has_token())
  })
})

test_that("lxr_has_token returns FALSE when token is empty", {
  withr::with_envvar(c(LIXINGR_TOKEN = ""), {
    expect_false(lxr_has_token())
  })
})

test_that("lxr_clear_token removes token from environment", {
  withr::with_envvar(c(LIXINGR_TOKEN = "token-to-clear"), {
    expect_true(lxr_has_token())
    expect_message(lxr_clear_token(), "Token cleared")
    expect_false(lxr_has_token())
  })
})

test_that("token auto-fetch works in make_endpoint generated functions", {
  make_ep <- getFromNamespace("make_endpoint", "lixingr2")

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
    optional = "stock_codes"
  )

  # Test auto-fetch from environment
  withr::with_envvar(c(LIXINGR_TOKEN = "env-token"), {
    fn(stock_codes = "600519")
    body <- captured$body$data
    expect_equal(body$token, jsonlite::unbox("env-token"))
  })

  # Test explicit token overrides environment
  withr::with_envvar(c(LIXINGR_TOKEN = "env-token"), {
    fn(token = "explicit-token", stock_codes = "600519")
    body <- captured$body$data
    expect_equal(body$token, jsonlite::unbox("explicit-token"))
  })
})
