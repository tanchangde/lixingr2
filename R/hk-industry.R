#' Get Hong Kong Industry Information
#'
#' @description Retrieve basic information for Hong Kong industries.
#'
#' @inheritParams common_params
#' @param stock_codes Industry codes as a character vector. Defaults to all
#'   industries if not provided. Format: `c("H50", "H5010")`.
#' @param source Industry classification source as a character string.
#'   Currently supports: `"hsi"` (Hang Seng).
#' @param level Industry classification level as a character string.
#'   Supported values: `"one"` (first level), `"two"` (second level),
#'   `"three"` (third level).
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/industry)
#'
#' @rdname lxr_hk_industry
#' @export
lxr_hk_industry <- make_endpoint(
  endpoint = "hk/industry",
  required = c("token", "source"),
  optional = c("stock_codes", "level")
)
