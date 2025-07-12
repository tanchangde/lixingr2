#' Get detailed stock information
#'
#' @param token Authentication token.
#' @param stock_codes A vector of stock codes. If not provided, all stock codes 
#'   will be queried. Example format: \code{c("300750", "600519", "600157")}.
#' @param fs_table_type Financial statement type. Currently supported types 
#'   include: \code{non_financial}, \code{bank}, \code{insurance}, 
#'   \code{security}, and \code{other_financial}.
#' @param mutual_markets Stock Connect type, for example: \code{'ha'}. 
#'   Currently supports \code{ha} (Shanghai-Hong Kong Stock Connect).
#' @param include_delisted Whether to include delisted stocks. \code{FALSE} or 
#'   \code{NULL} means not included.
#' @param .max_tries Maximum number of retry attempts. Can be set via option 
#'   "lxg.max_tries". Default is 4.
#' @param .backoff_fun Function to calculate backoff delay in seconds between 
#'   retries. Can be set via option "lxg.backoff_fun".
#' @param .retry_on Predicate function that takes a single argument (the 
#'   response) and returns TRUE or FALSE to specify whether the response 
#'   represents a transient error that should trigger a retry. Can be set via 
#'   option "lxg.retry_on".
#'
#' @return Returns a parsed API response list. See 
#'   \href{https://www.lixinger.com/open/api/doc?api-key=cn/company}{API documentation} 
#'   for details.
#'
#' @rdname lxr_cn_company
#' @export
lxr_cn_company <- make_endpoint(
  endpoint = "cn/company",
  required = "token",
  optional = c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted")
)