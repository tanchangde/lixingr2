#' Common Parameter Descriptions
#'
#' @param token Authentication token, must be a character string.
#' @param options A list for advanced control over the request.
#'   
#'   - `extra_headers`: Additional headers to include in the request, passed as a 
#'     named list. Default is `list("Content-Type" = "application/json")`.
#'   
#'   - `call_config`: Additional configuration parameters, passed as a named list.
#'     Can be partially or fully overridden.
#'     Default is `list(max_tries = 4L, backoff_fun = NULL, retry_on = NULL,
#'     return_format = "list", verbosity = NULL)`.
#'
#'     - `max_tries`: Maximum number of retry attempts.
#'
#'     - `backoff_fun`: Function to calculate backoff delay in seconds between retries.
#'       Default is an exponential backoff with jitter. The delay increases with
#'       the number of retry attempts and includes randomness to reduce conflicts.
#'       The maximum delay is capped at 10 seconds.
#'
#'     - `retry_on`: Predicate function that takes a single argument (the response)
#'       and returns TRUE or FALSE to specify whether the response represents a
#'       transient error that should trigger a retry. Default retries on HTTP status
#'       codes 429 (Too Many Requests) and 500+ (Server Errors).
#'
#'     - `return_format`: Output format options:
#'       - `"json"`: Returns raw JSON data.
#'       - `"list"`: Returns data as an R list.
#'       - `"tibble"`: Returns data as a tibble (experimental).
#'       - `"resp"`: Returns the performed request object.
#'
#'     - `verbosity`: Controls the verbosity of printed information. This is a
#'       wrapper around [httr2::req_verbose()] that uses an integer to specify verbosity levels:
#'       - `0`: No output.
#'       - `1`: Show headers.
#'       - `2`: Show headers and bodies.
#'       - `3`: Show headers, bodies, and curl status messages.
#'
#' @keywords internal
#' @name common_params
NULL

#' Date Parameter
#'
#' @param date The date for which data is to be retrieved, as a character string
#'   in "YYYY-MM-DD" format. The date should be based on Beijing Time (UTC+8).
#'
#' @keywords internal
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
#' @keywords internal
#' @name date_range_params
NULL

#' Stock Code Parameter
#'
#' @param stock_code A single stock code as a character string.
#'
#' @keywords internal
#' @name stock_code_param
NULL

#' Stock Codes Parameter
#'
#' @param stock_codes A vector of stock codes as character strings.
#'
#' @keywords internal
#' @name stock_codes_param
NULL

#' Limit Parameter
#'
#' @param limit The number of latest records to return.
#'
#' @keywords internal
#' @name limit_param
NULL

#' Common Return Descriptions
#'
#' @return A parsed API response.
#'
#' @keywords internal
#' @name common_return
NULL

#' Metrics List Parameter
#'
#' @param metrics_list A vector of string metrics, e.g., `c("mc", "pe_ttm", "pb", "dyr")`.
#'
#' Currently supported metrics:
#'
#' **Valuation Metrics**
#'
#' - PE-TTM : `pe_ttm`
#' - PE-TTM (ex-NRI) : `d_pe_ttm`
#' - PB : `pb`
#' - PB (ex-Goodwill) : `pb_wo_gw`
#' - PS-TTM : `ps_ttm`
#' - Dividend Yield : `dyr`
#' - PCF-TTM : `pcf_ttm`
#' - Stock Price : `sp`
#' - Price Change (%) : `spc`
#' - Intraday Range (%) : `spa`
#' - Trading Volume : `tv`
#' - Trading Value : `ta`
#' - Turnover Rate (%) : `to_r`
#' - Number of Shareholders : `shn`
#' - Market Capitalization : `mc`
#' - A-share Market Cap : `mc_om`
#' - Tradable Market Cap : `cmc`
#' - Free-float Market Cap : `ecmc`
#' - Free-float Market Cap / Holder : `ecmc_psh`
#' - Margin Purchase Value : `fpa`
#' - Margin Repayment Value : `fra`
#' - Margin Financing Balance : `fb`
#' - Short-sale Value : `ssa`
#' - Short-sale Repayment Value : `sra`
#' - Short Interest Balance : `sb`
#' - Northbound Connect Holdings (Shares) : `ha_sh`
#' - Northbound Connect Holdings (Value)  : `ha_shm`
#' - Northbound Connect Net Buy (Value)   : `mm_nba`
#'
#' **Valuation Statistics Metrics**
#'
#' Format: `metricsName.granularity.statisticsDataType`
#'
#' *metricsName*
#'
#' - PE-TTM : `pe_ttm`
#' - PE-TTM (ex-NRI) : `d_pe_ttm`
#' - PB : `pb`
#' - PB (ex-Goodwill) : `pb_wo_gw`
#' - PS-TTM : `ps_ttm`
#'
#' *granularity*
#'
#' - Since Listing : `fs`
#' - 20 Years : `y20`
#' - 10 Years : `y10`
#' - 5 Years : `y5`
#' - 3 Years : `y3`
#' - 1 Year : `y1`
#'
#' *statisticsDataType*
#'
#' - Percentile Position (%) : `cvpos`
#' - 20th-percentile Value : `q2v`
#' - 50th-percentile Value : `q5v`
#' - 80th-percentile Value : `q8v`
#' - Minimum Value : `minv`
#' - Maximum Value : `maxv`
#' - Maximum Positive Value : `maxpv`
#' - Average Value : `avgv`
#'
#' @keywords internal
#' @name metrics_list_cn_com_fundmtl
NULL
