#' Common Parameter Descriptions
#'
#' @param token Authentication token.
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
#'
#' @name common_params
NULL

#' Date Range Parameters
#'
#' @param start_date The start date in "YYYY-MM-DD" format.
#' @param end_date The end date in "YYYY-MM-DD" format. If not provided, the 
#'   default value is last Monday. The interval between the start and end dates
#'   must not exceed 10 years.
#'
#' @name date_range_params
NULL

#' Stock Code Parameter
#'
#' @param stock_code A single stock code, e.g., "300750".
#'
#' @name stock_code_param
NULL

#' Limit Parameter
#'
#' @param limit The number of latest records to return. This parameter is only 
#'   effective when requesting data within a date range.
#'
#' @name limit_param
NULL

#' Get detailed stock information
#'
#' @inheritParams common_params
#' @param stock_codes A vector of stock codes. If not provided, all stock codes
#'   will be queried.
#' @param fs_table_type Financial statement type. Currently supported types
#'   include: \code{non_financial}, \code{bank}, \code{insurance},
#'   \code{security}, and \code{other_financial}.
#' @param mutual_markets Stock Connect type, for example: \code{'ha'}.
#'   Currently supports \code{ha} (Shanghai-Hong Kong Stock Connect).
#' @param include_delisted Whether to include delisted stocks. \code{FALSE} or
#'   \code{NULL} means not included.
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

#' Get Company Profile Data
#'
#' @inheritParams common_params
#' @param stock_codes A vector of stock codes. The length of \code{stock_codes} 
#'   must be between 1 and 100.Example format: \code{c("300750", "600519", "600157")}.
#'
#' @return Returns a parsed API response list. See
#'   \href{https://www.lixinger.com/open/api/doc?api-key=cn/company/profile}{API documentation}
#'   for details.
#'
#' @rdname lxr_cn_company_profile
#' @export
lxr_cn_company_profile <- make_endpoint(
  endpoint = "cn/company/profile",
  required = c("token", "stock_codes")
)

#' Retrieve Share Capital Change Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#'
#' @return A parsed API response list. For details, refer to the 
#'   \href{https://www.lixinger.com/open/api/doc?api-key=cn/company/equity-change}{API documentation}.
#'
#' @rdname lxr_cn_company_equity_change
#' @export
lxr_cn_company_equity_change <- make_endpoint(
  endpoint = "cn/company/equity-change",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Candlestick Data
#' 
#' @description Adjusted prices are calculated only for the selected time period, 
#' while trading volume is not adjusted.
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @param type Adjustment type, e.g., "lxr_fc_rights". Supported types include:
#'   No adjustment: \code{ex_rights}, Lixinger pre-adjustment: \code{lxr_fc_rights}, 
#'   Pre-adjustment: \code{fc_rights}, Post-adjustment: \code{bc_rights}.
#' @param adjust_forward_date The starting date for pre-adjustment. Must be used 
#'   with \code{end_date} and must be greater than or equal to \code{end_date}. 
#'   Required when requesting adjusted data; defaults to \code{end_date} if not provided.
#' @param adjust_backward_date The starting date for post-adjustment. Must be used 
#'   with \code{start_date} and must be less than or equal to \code{start_date}. 
#'   Required when requesting adjusted data; defaults to \code{start_date} if not provided.
#' @inheritParams date_range_params
#' @inheritParams limit_param
#'
#' @return 返回解析后的API响应列表。详情请参考 
#'   \href{https://www.lixinger.com/open/api/doc?api-key=cn/company/candlestick}{API文档}。
#'
#' @rdname lxr_cn_company_candlestick
#' @export
lxr_cn_company_candlestick <- make_endpoint(
  endpoint = "cn/company/candlestick",
  required = c("token", "stock_code", "type", "start_date"),
  optional = c("end_date", "adjust_forward_date", "adjust_backward_date", "limit")
)


