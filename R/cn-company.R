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
#' @param stock_codes A vector of stock codes as character strings. For example:
#'   `c("300750", "600519", "600157")`. If not provided, all stock codes
#'   will be queried.
#' @param fs_table_type Financial statement type as a character string. Currently
#'   supported types include: `"non_financial"`, `"bank"`, `"insurance"`,
#'   `"security"`, and `"other_financial"`.
#' @param mutual_markets Stock Connect type as a character string. Currently
#'   supports `"ha"` (Shanghai-Hong Kong Stock Connect).
#' @param include_delisted Whether to include delisted stocks. `FALSE` or
#'   `NULL` means not included.
#'
#' @return Returns a parsed API response list. See
#'   [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company)
#'   for details.
#'
#' @rdname lxr_cn_com
#' @export
lxr_cn_com <- make_endpoint(
  endpoint = "cn/company",
  required = "token",
  optional = c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted")
)

#' Get Company Profile Data
#'
#' @inheritParams common_params
#' @param stock_codes A vector of stock codes as character strings. The length
#'   of `stock_codes` must be between 1 and 100.Example format:
#'   `c("300750", "600519", "600157")`.
#'
#' @return Returns a parsed API response list. See
#'   [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/profile)
#'   for details.
#'
#' @rdname lxr_cn_com_profile
#' @export
lxr_cn_com_profile <- make_endpoint(
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
#'   [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/equity-change).
#'
#' @rdname lxr_cn_com_equity_change
#' @export
lxr_cn_com_equity_change <- make_endpoint(
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
#' @param type Adjustment type, e.g., `"lxr_fc_rights"`. Supported types include:
#'   No adjustment: `ex_rights`, Lixinger pre-adjustment: `lxr_fc_rights`,
#'   Pre-adjustment: `fc_rights`, Post-adjustment: `bc_rights`.
#' @param adjust_forward_date The starting date for pre-adjustment as a character string.
#'   Must be used with `end_date` and must be greater than or equal to `end_date`.
#'   Required when requesting adjusted data; defaults to `end_date` if not provided.
#' @param adjust_backward_date The starting date for post-adjustment as a character string.
#'   Must be used with `start_date` and must be less than or equal to `start_date`.
#'   Required when requesting adjusted data; defaults to `start_date` if not provided.
#' @inheritParams date_range_params
#' @inheritParams limit_param
#'
#' @return A parsed API response list. For details, refer to the
#'   [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/candlestick)。
#'
#' @rdname lxr_cn_com_candlestick
#' @export
lxr_cn_com_candlestick <- make_endpoint(
  endpoint = "cn/company/candlestick",
  required = c("token", "stock_code", "type", "start_date"),
  optional = c("end_date", "adjust_forward_date", "adjust_backward_date", "limit")
)

#' Retrieve Shareholders Number Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#'
#' @return A parsed API response list. For details, refer to the
#'   [API documentation](https://open.lixinger.com/api/cn/company/shareholders-num)。
#'
#' @rdname lxr_cn_com_shareholders_num
#' @export
lxr_cn_com_shareholders_num <- make_endpoint(
  endpoint = "cn/company/shareholders-num",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Senior Executive Shareholding Change Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' 
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range.
#'
#' @return A parsed API response list. For details, refer to the
#'   [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/senior-executive-shares-change)。
#'
#' @rdname lxr_cn_com_senior_executive_shares_change
#' @export
lxr_cn_com_senior_executive_shares_change <- make_endpoint(
  endpoint = "cn/company/senior-executive-shares-change",
  required = c("token"),
  optional = c("stock_code", "date", "start_date", "end_date", "limit")
)

#' Retrieve Major Shareholders Shareholding Change Data
#'
#' @inheritParams lxr_cn_com_senior_executive_shares_change
#' 
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range.
#'
#' @return A parsed API response list. For details, refer to the
#'   [API documentation](https://open.lixinger.com/api/cn/company/major-shareholders-shares-change)。
#'
#' @rdname lxr_cn_com_major_shareholders_shares_change
#' @export
lxr_cn_com_major_shareholders_shares_change <- make_endpoint(
  endpoint = "cn/company/major-shareholders-shares-change",
  required = c("token"),
  optional = c("stock_code", "date", "start_date", "end_date", "limit")
)
