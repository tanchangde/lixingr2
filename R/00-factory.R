#' Unnest dataframes in list columns
#'
#' @description Unnest a dataframe with list columns, where the list columns
#'   contain nested dataframes.
#'
#' @param df A dataframe with one or more list columns containing nested
#'   dataframes to be unnested.
#' @return A dataframe where each list column has been unnested into
#'   multiple rows.
lxr_unnest <- function(df) {
  list_cols <- df |>
    purrr::keep(~ is.list(.x)) |>
    names()
  non_list_cols <- setdiff(names(df), list_cols)

  if (length(list_cols) == 0) {
    return(df)
  }

  df_result <- NULL
  for (col in list_cols) {
    df_expanded <- df |>
      dplyr::select(tidyselect::all_of(c(non_list_cols, col))) |>
      dplyr::mutate(original_row_id = dplyr::row_number()) |>
      tidyr::unnest(cols = tidyselect::all_of(col), names_sep = ".", keep_empty = TRUE) |>
      dplyr::group_by(.data$original_row_id) |>
      dplyr::mutate(grouped_row_id = dplyr::row_number()) |>
      dplyr::ungroup()

    if (is.null(df_result)) {
      df_result <- df_expanded
    } else {
      df_result <- dplyr::full_join(
        df_result,
        df_expanded,
        by = c("original_row_id", "grouped_row_id", non_list_cols)
      )
    }
  }

  df_result |>
    dplyr::select(-"original_row_id", -"grouped_row_id")
}

#' Create a generic API client
#'
#' Builds a lightweight client object that stores the base URL, default HTTP
#' headers, and request-level configuration. While the default `base_url`
#' targets the *Lixinger* Open API, this function is designed to support
#' any JSON-based HTTP service.
#'
#' @param base_url Character. Base URL of the target API.
#'    Default: `"https://open.lixinger.com/api"`.
#' @param default_hdrs Named list. Headers sent with every request,
#'    e.g., `list("Content-Type" = "application/json")`.
#' @param default_cfg List. Request configuration such as retry policy and
#'    response format. See *Details*.
#' @param name_transform Function. Transforms R argument names to the naming
#'    convention required by the API (default:`snakecase::to_lower_camel_case`).
#' @param array_params Character vector. Parameters that must be encoded as JSON
#'    arrays rather than scalars.
#'
#' @return An S3 object of class "api_client".
#' @export
new_client <- function(
    base_url = "https://open.lixinger.com/api",
    default_hdrs = list("Content-Type" = "application/json"),
    default_cfg = list(
      max_tries     = 4L,
      backoff_fun   = NULL,
      retry_on      = NULL,
      return_format = "list",
      verbosity     = NULL
    ),
    name_transform = snakecase::to_lower_camel_case,
    array_params = c("stockCodes", "mutualMarkets", "metricsList")) {
  if (!is.list(default_hdrs)) {
    cli::cli_abort(c(
      "Invalid {.var default_hdrs}",
      "x" = "{.var default_hdrs} must be a list",
      "i" = "You provided: {.cls {class(default_hdrs)}}"
    ))
  }

  if (!is.function(name_transform)) {
    cli::cli_abort(c(
      "Invalid {.var name_transform}",
      "x" = "{.var name_transform} must be a function",
      "i" = "You provided: {.cls {class(name_transform)}}"
    ))
  }

  tryCatch(
    httr2::url_parse(base_url),
    error = function(e) {
      cli::cli_abort(c(
        "Invalid URL format",
        "x" = "Could not parse base_url: {.url {base_url}}",
        "i" = "Make sure it's a valid URL"
      ))
    }
  )

  structure(
    list(
      base_url       = base_url,
      default_hdrs   = default_hdrs,
      default_cfg    = default_cfg,
      name_transform = name_transform,
      array_params   = array_params
    ),
    class = c("api_client", "list")
  )
}

#' Low-level request helper
#'
#' @param client An API client produced by `new_client()`.
#' @param path Character. Endpoint path (e.g., `"cn/company"`).
#' @param body List. Request body to be encoded as JSON.
#' @param hdrs Named character vector. Extra headers merged with client defaults.
#' @param cfg List. Per-call overrides of `client$default_cfg`.
#'
#' @return Depending on `return_format`: a JSON string, list, tibble, or raw
#'   `httr2` response.
#' @export
send_request <- function(client, path, body = NULL, hdrs = list(), cfg = list()) {
  if (!inherits(client, "api_client")) {
    cli::cli_abort(c(
      "Invalid client object",
      "x" = "client must be created with {.code new_client()}",
      "i" = "You provided: {.cls {class(client)}}"
    ))
  }

  if (!is.character(path) || length(path) != 1) {
    cli::cli_abort(c(
      "Invalid path",
      "x" = "path must be a single character string",
      "i" = "You provided: {.cls {class(path)}} of length {length(path)}"
    ))
  }

  cfg <- utils::modifyList(client$default_cfg, cfg)
  hdrs <- purrr::reduce(list(client$default_hdrs, hdrs), utils::modifyList)

  valid_formats <- c("json", "list", "tibble", "resp")
  if (!cfg$return_format %in% valid_formats) {
    cli::cli_abort(c(
      "Invalid return_format",
      "x" = "return_format must be one of: {.or {valid_formats}}",
      "i" = "You provided: {.val {cfg$return_format}}"
    ))
  }

  if (is.null(cfg$backoff_fun)) {
    cfg$backoff_fun <- function(attempt) {
      min(0.5 * 2^(attempt - 1) + stats::runif(1, 0, .4), 10)
    }
  }

  if (is.null(cfg$retry_on)) {
    cfg$retry_on <- function(resp) {
      s <- httr2::resp_status(resp)
      s == 429L || s >= 500L
    }
  }

  req <- httr2::request(client$base_url) |>
    httr2::req_url_path_append(path) |>
    httr2::req_headers(!!!hdrs) |>
    httr2::req_body_json(body, auto_unbox = FALSE) |>
    httr2::req_error(is_error = ~FALSE) |>
    httr2::req_retry(
      max_tries        = cfg$max_tries,
      backoff          = cfg$backoff_fun,
      is_transient     = cfg$retry_on,
      retry_on_failure = TRUE
    )

  resp <- tryCatch(
    {
      httr2::req_perform(req, verbosity = cfg$verbosity)
    },
    error = function(e) {
      if (inherits(e, "httr2_error")) {
        cli::cli_abort(c(
          "Network request failed",
          "x" = conditionMessage(e),
          "i" = "Check your internet connection and API endpoint"
        ), parent = e)
      }
    }
  )

  status_code <- httr2::resp_status(resp)
  if (status_code >= 400) {
    error_body_raw <- httr2::resp_body_string(resp)
    error_body <- tryCatch(
      jsonlite::fromJSON(error_body_raw, simplifyVector = FALSE),
      error = function(e) error_body_raw
    )
    error_msg <- if (is.list(error_body)) {
      jsonlite::toJSON(error_body, pretty = TRUE, auto_unbox = TRUE)
    } else {
      as.character(error_body)
    }

    error_title <- switch(as.character(status_code),
      "400" = "Bad Request",
      "401" = "Unauthorized",
      "403" = "Forbidden",
      "404" = "Not Found",
      "429" = "Too Many Requests",
      "500" = "Internal Server Error",
      "502" = "Bad Gateway",
      "503" = "Service Unavailable",
      paste("HTTP Error", status_code)
    )

    cli::cli_abort(c(
      "{error_title}",
      "x" = "Status code: {.strong {status_code}}",
      "!" = "API error: {error_msg}",
      "i" = "Endpoint: {.url {paste0(client$base_url, '/', path)}}"
    ), class = paste0("http_", status_code))
  }

  switch(cfg$return_format,
    json = httr2::resp_body_string(resp),
    list = httr2::resp_body_json(resp),
    tibble = {
      resp_data <- httr2::resp_body_json(resp, simplifyVector = TRUE) |>
        magrittr::use_series("data")

      if (length(resp_data) > 0) {
        resp_data |>
          jsonlite::flatten() |>
          lxr_unnest() |>
          tibble::as_tibble()
      } else {
        cli::cli_abort("i" = "Query was successful, but no data returned.")
      }
    },
    resp = resp
  )
}

#' Endpoint factory
#'
#' @param client An API client.
#' @param endpoint Character. API path relative to `base_url`.
#' @param required Character vector. Names of parameters **required** by this endpoint.
#' @param optional Character vector. Names of optional parameters.
#'
#' @return A user-callable function.
#' @export
make_endpoint <- function(client = new_client(), endpoint, required, optional = NULL) {
  fmls <- c(
    rlang::set_names(purrr::map(required, ~ rlang::missing_arg()), required),
    rlang::set_names(purrr::map(optional, ~ rlang::expr(NULL)), optional),
    options = rlang::expr(list())
  )

  checks <- purrr::map(
    required,
    ~ rlang::expr(rlang::check_required(!!rlang::sym(.x)))
  )

  all_body_args <- c(required, optional)

  fn_body <- rlang::expr({
    !!!checks

    body_args <- rlang::env_get_list(
      env     = rlang::current_env(),
      nm      = !!all_body_args,
      default = list(rlang::missing_arg())
    ) |>
      purrr::discard(is.null)
    names(body_args) <- (!!client$name_transform)(names(body_args))

    body_args <- purrr::imap(body_args, function(x, nm) {
      if (nm %in% (!!client$array_params)) x else jsonlite::unbox(x)
    })

    extra_headers <- options$extra_headers %||% list()
    call_config <- options$call_config %||% list()

    send_request(
      client = !!client,
      path   = !!endpoint,
      body   = body_args,
      hdrs   = extra_headers,
      cfg    = call_config
    )
  })

  rlang::new_function(fmls, fn_body, env = rlang::caller_env())
}
