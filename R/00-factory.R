#' Generate API endpoint function
#'
#' @param endpoint  API path, the personalized part of the API path
#' @param required  Character vector of required parameter names
#' @param optional  Character vector of optional parameter names
#'
#' @return Returns an API endpoint function
make_endpoint <- function(endpoint, required, optional = NULL) {
  fmls <- c(
    rlang::set_names(
      purrr::map(required, ~ rlang::missing_arg()),
      required
    ),
    rlang::set_names(
      purrr::map(optional, ~ rlang::expr(NULL)),
      optional
    ),
    .max_tries = rlang::expr(getOption("lxg.max_tries", 4L)),
    .backoff_fun = rlang::expr(getOption("lxg.backoff_fun", NULL)),
    .retry_on = rlang::expr(getOption("lxg.retry_on", NULL))
  )

  check_calls <- purrr::map(
    required,
    ~ rlang::expr(rlang::check_required(!!rlang::sym(.x)))
  )

  body <- rlang::expr({
    !!!check_calls

    max_tries <- .max_tries
    backoff_fun <- .backoff_fun
    retry_on <- .retry_on

    query_params <- as.list(environment()) |>
      purrr::discard(is.null)
    query_params <- query_params[!startsWith(names(query_params), ".")]

    names(query_params) <- purrr::map_chr(
      names(query_params),
      ~ stringr::str_replace_all(
        .x, "_[a-z]",
        ~ toupper(stringr::str_sub(.x, start = -1))
      )
    )

    array_params <- c("stockCodes", "mutualMarkets", "metricsList")
    request_params <- purrr::imap(query_params, ~ {
      param_name <- .y
      if (!param_name %in% array_params) {
        jsonlite::unbox(.x)
      } else {
        .x
      }
    })

    if (is.null(backoff_fun)) {
      backoff_fun <- function(attempt) {
        base   <- 0.5 * 2^(attempt - 1)
        jitter <- stats::runif(1, 0, 0.4)
        min(base + jitter, 10)
      }
    }

    if (is.null(retry_on)) {
      retry_on <- function(resp) {
        status <- httr2::resp_status(resp)
        status == 429 || status >= 500
      }
    }

    req <- httr2::request("https://open.lixinger.com/api") |>
      httr2::req_headers("Content-Type" = "application/json") |>
      httr2::req_url_path_append(!!endpoint) |>
      httr2::req_body_json(data = request_params, auto_unbox = FALSE) |>
      httr2::req_retry(
        max_tries = max_tries,
        backoff = backoff_fun,
        is_transient = retry_on
      )

    req |>
      httr2::req_perform() |>
      httr2::resp_body_json()
  })

  rlang::new_function(fmls, body, env = rlang::caller_env())
}
