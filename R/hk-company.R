#' Get Detailed Stock Information
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @param fs_table_type Financial statement type as a character string. Currently
#'   supported types include: `"non_financial"`, `"bank"`, `"insurance"`,
#'   `"security"`, `"reit"` and `"other_financial"`.
#' @param mutual_markets Stock Connect type as a character string. Currently
#'   supports `"ah"` (Shanghai-Hong Kong Stock Connect).
#' @param include_delisted Whether to include delisted stocks. `FALSE` or
#'   `NULL` means not included.
#'
#' @details If `stock_codes` is not provided, all stock codes will be queried.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company)
#'
#' @rdname lxr_hk_com
#' @export
lxr_hk_com <- make_endpoint(
  endpoint = "hk/company",
  required = "token",
  optional = c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted")
)

#' Get Company Profile Data
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/profile)
#'
#' @rdname lxr_hk_com_profile
#' @export
lxr_hk_com_profile <- make_endpoint(
  endpoint = "hk/company/profile",
  required = c("token", "stock_codes")
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
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @param adjust_forward_date The starting date for pre-adjustment as a character string.
#'   Must be used with `end_date` and must be greater than or equal to `end_date`.
#'   Required when requesting adjusted data; defaults to `end_date` if not provided.
#' @param adjust_backward_date The starting date for post-adjustment as a character string.
#'   Must be used with `start_date` and must be less than or equal to `start_date`.
#'   Required when requesting adjusted data; defaults to `start_date` if not provided.
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/candlestick)
#'
#' @rdname lxr_hk_com_candlestick
#' @export
lxr_hk_com_candlestick <- make_endpoint(
  endpoint = "hk/company/candlestick",
  required = "token",
  optional = c(
    "stock_code", "type", "date", "start_date", "end_date",
    "adjust_forward_date", "adjust_backward_date", "limit"
  )
)

#' Retrieve Share Capital Change Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/equity-change)
#'
#' @rdname lxr_hk_com_equity_change
#' @export
lxr_hk_com_equity_change <- make_endpoint(
  endpoint = "hk/company/equity-change",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Employee Information
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/employee)
#'
#' @rdname lxr_hk_com_equity_change
#' @export
lxr_hk_com_employee <- make_endpoint(
  endpoint = "hk/company/employee",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Revenue Composition Data
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/operation-revenue-constitution)
#'
#' @rdname lxr_hk_com_operation_revenue_constitution
#' @export
lxr_hk_com_operation_revenue_constitution <- make_endpoint(
  endpoint = "hk/company/operation-revenue-constitution",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Get Stock Industry Information
#'
#' @inherit lxr_cn_com_indices
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/industries)
#'
#' @rdname lxr_hk_com_industries
#' @export
lxr_hk_com_industries <- make_endpoint(
  endpoint = "hk/company/industries",
  required = c("token", "stock_code"),
  optional = c("date")
)

#' Retrieve Non-Financial Fundamental Data
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#'
#' @param metrics_list A vector of string metrics, e.g., `c("mc", "pe_ttm", "pb", "dyr")`.
#'
#' Currently supported metrics:
#'
#' **Valuation Metrics**
#'
#' - PE-TTM : `pe_ttm`
#' - PB : `pb`
#' - PS-TTM : `ps_ttm`
#' - Dividend Yield : `dyr`
#' - PCF-TTM : `pcf_ttm`
#' - Stock Price : `sp`
#' - Price Change (%) : `spc`
#' - Intraday Range (%) : `spa`
#' - Trading Volume : `tv`
#' - Trading Value : `ta`
#' - Turnover Rate (%) : `to_r`
#' - Market Capitalization : `mc`
#' - H-share Market Cap : `mc_om`
#' - Southbound Shareholding Volume : `ah_sh`
#' - Southbound Shareholding Value : `ah_shm`
#' - Southbound Net Buy Value : `mm_nba`
#' - Shares Per Lot : `sharesPerLot`
#'
#' **Valuation Statistics Metrics**
#'
#' Format: `metricsName.granularity.statisticsDataType`
#'
#' *metricsName*
#'
#' - PE-TTM : `pe_ttm`
#' - PB : `pb`
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
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100. When assigning
#'   a value to `start_date`, the length of `stock_codes` must be 1. Either
#'   `start_date` or `date` must be provided. `limit` is only effective when
#'   requesting data within a date range. When the length of `stock_codes` is
#'   greater than 1, a maximum of 48 metrics can be selected; when the length of
#'   `stock_codes` equals 1, a maximum of 36 metrics can be retrieved.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/fundamental/non_financial)
#'
#' @examples
#' \dontrun{
#' lxr_hk_com_fundmtl_non_financial(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   date = "2025-07-08",
#'   stock_codes = "00700",
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y3.cvpos")
#' )
#' }
#'
#' @rdname lxr_hk_com_fundmtl_non_financial
#' @export
lxr_hk_com_fundmtl_non_financial <- make_endpoint(
  endpoint = "hk/company/fundamental/non_financial",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit")
)

#' Retrieve Financial Statement Data for Non-Financial Listed Companies
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @param metrics_list A vector of metrics in the format
#'   `[granularity].[tableName].[fieldName].[expressionCalculateType]`.
#'   For example, to retrieve the cumulative original value of total operating
#'   income and the year-on-year value of accounts receivable for the current
#'   period, set `metrics_list` to `c("q.ps.toi.t", "q.bs.ar.c_y2y")`. Refer to
#'   the API documentation for the full list of supported metrics.
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100. When assigning
#'   a value to `start_date`, the length of `stock_codes` must be 1. Either
#'   `start_date` or `date` must be provided. Passing `latest` as the value for
#'   `date` will retrieve the most recent financial statement data within the
#'   last 1.1 years.`limit` is only effective when requesting data within a date
#'   range. When the length of `stock_codes` is greater than 1, a maximum of 48
#'   metrics can be selected; when the length of `stock_codes` equals 1,
#'   a maximum of 128 metrics can be retrieved.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/fs/non_financial)
#'
#' @examples
#' \dontrun{
#' lxr_hk_com_fs_non_financial(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   start_date = "2024-07-01",
#'   end_date = "2025-07-01",
#'   stock_codes = "00700",,
#'   metrics_list = "q.ps.toi.t"
#' )
#' }
#'
#' @rdname lxr_hk_com_fs_non_financial
#' @export
lxr_hk_com_fs_non_financial <- make_endpoint(
  endpoint = "hk/company/fs/non_financial",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit")
)
