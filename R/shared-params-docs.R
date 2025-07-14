#' Common Parameter Descriptions
#'
#' @param token Authentication token, must be a character string.
#' @param .max_tries Maximum number of retry attempts. Can be set via option
#'   "lxg.max_tries". Default is 4.
#' @param .backoff_fun Function to calculate backoff delay in seconds between
#'   retries. Default is an exponential backoff with jitter. The delay increases
#'   with the number of retry attempts and includes randomness to reduce conflicts.
#'   The maximum delay is capped at 10 seconds. Can be set via option "lxg.backoff_fun".
#' @param .retry_on Predicate function that takes a single argument (the
#'   response) and returns TRUE or FALSE to specify whether the response
#'   represents a transient error that should trigger a retry. Default retries
#'   on HTTP status codes 429 (Too Many Requests) and 500+ (Server Errors).
#'   Can be set via option "lxg.retry_on".
#' @param .return_format Format of the returned data. Must be one of `"json"`,
#'   `"list"`, or `"tibble"`. Defaults to `"json"`.
#'
#' @name common_params
NULL

#' Date Parameter
#'
#' @param date The date for which data is to be retrieved, as a character string
#'   in "YYYY-MM-DD" format. The date should be based on Beijing Time (UTC+8).
#'
#' @name date_param
NULL

#' Date Range Parameters
#'
#' @param start_date The start date as a character string in "YYYY-MM-DD" format.
#'   The date should be based on Beijing Time (UTC+8).
#' @param end_date The end date as a character string in "YYYY-MM-DD" format.
#'   If not provided, the default value is last Monday. The interval between
#'   the start and end dates must not exceed 10 years. The date should be based
#'   on Beijing Time (UTC+8).
#'
#' @name date_range_params
NULL

#' Stock Code Parameter
#'
#' @param stock_code A single stock code as a character string, e.g., "300750".
#'
#' @name stock_code_param
NULL

#' Stock Codes Parameter
#'
#' @param stock_codes A vector of stock codes as character strings. Example format:
#'   `c("300750", "600519", "600157")`.
#'
#' @name stock_codes_param
NULL

#' Limit Parameter
#'
#' @param limit The number of latest records to return. This parameter is only
#'   effective when requesting data within a date range.
#'
#' @name limit_param
NULL

#' Common Return Descriptions
#'
#' @return
#' A parsed API response. The format of the returned data depends on the `.return_format` parameter:
#'   - `"json"`: Returns raw JSON data.
#'   - `"list"`: Returns data as an R list.
#'   - `"tibble"`: Returns data as a tibble (if implemented).
#'   - `"resp"`: Returns the performed request object.
#'
#' @name common_return
NULL
