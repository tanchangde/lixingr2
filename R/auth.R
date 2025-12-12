#' Set Lixinger API Token
#'
#' Store the Lixinger API token in an environment variable for automatic use
#' by API functions.
#'
#' @param token Character string. Your Lixinger API token.
#'
#' @return Invisibly returns the token.
#'
#' @examples
#' \dontrun{
#' lxr_set_token("your-api-token")
#' }
#'
#' @seealso [lxr_get_token()] for retrieving the stored token.
#' @export
lxr_set_token <- function(token) {
  if (!is.character(token) || length(token) != 1 || nchar(token) == 0) {
    cli::cli_abort(c(
      "Invalid token",
      "x" = "Token must be a non-empty character string",
      "i" = "You provided: {.cls {class(token)}}"
    ))
  }
  Sys.setenv(LIXINGR_TOKEN = token)
  cli::cli_alert_success("Token set successfully")
  invisible(token)
}

#' Get Lixinger API Token
#'
#' Retrieve the Lixinger API token from the environment variable.
#'
#' @return Character string. The API token.
#'
#' @examples
#' \dontrun{
#' token <- lxr_get_token()
#' }
#'
#' @seealso [lxr_set_token()] for setting the token.
#' @export
lxr_get_token <- function() {
  token <- Sys.getenv("LIXINGR_TOKEN", unset = NA)
  if (is.na(token) || token == "") {
    cli::cli_abort(c(
      "API token not found",
      "i" = "Use {.fn lxr_set_token} to set your token",
      "i" = "Or set the {.env LIXINGR_TOKEN} environment variable"
    ))
  }
  token
}

#' Check if Token is Set
#'
#' Check whether a Lixinger API token is available.
#'
#' @return Logical. `TRUE` if token is set, `FALSE` otherwise.
#'
#' @examples
#' lxr_has_token()
#'
#' @export
lxr_has_token <- function() {
  token <- Sys.getenv("LIXINGR_TOKEN", unset = NA)
  !is.na(token) && token != ""
}

#' Clear Lixinger API Token
#'
#' Remove the stored API token from the environment variable.
#'
#' @return Invisibly returns `NULL`.
#'
#' @examples
#' \dontrun{
#' lxr_clear_token()
#' }
#'
#' @export
lxr_clear_token <- function() {
 Sys.unsetenv("LIXINGR_TOKEN")
 cli::cli_alert_info("Token cleared")
  invisible(NULL)
}
