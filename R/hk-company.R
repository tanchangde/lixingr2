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
#' @rdname lxr_hk_com_employee
#' @export
lxr_hk_com_employee <- make_endpoint(
  endpoint = "hk/company/employee",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Repurchase Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/repurchase)
#'
#' @rdname lxr_hk_com_repurchase
#' @export
lxr_hk_com_repurchase <- make_endpoint(
  endpoint = "hk/company/repurchase",
  required = c("token"),
  optional = c("stock_code", "date", "start_date", "end_date", "limit")
)

#' Retrieve Short Selling Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/short-selling)
#'
#' @rdname lxr_hk_com_short_selling
#' @export
lxr_hk_com_short_selling <- make_endpoint(
  endpoint = "hk/company/short-selling",
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

#' Retrieve Stock Index
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_param
#' @inherit common_return return
#'
#' @details When `date` is NULL, the query will return the current data.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/indices)
#'
#' @rdname lxr_hk_com_indices
#' @export
lxr_hk_com_indices <- make_endpoint(
  endpoint = "hk/company/indices",
  required = c("token", "stock_code"),
  optional = c("date")
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

#' Retrieve Announcement Information
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/announcement)
#'
#' @rdname lxr_hk_com_announcement
#' @export
lxr_hk_com_announcement <- make_endpoint(
  endpoint = "hk/company/announcement",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Latest Shareholders Information
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/latest-shareholders)
#'
#' @rdname lxr_hk_com_latest_shareholders
#' @export
lxr_hk_com_latest_shareholders <- make_endpoint(
  endpoint = "hk/company/latest-shareholders",
  required = c("token", "stock_code")
)

#' Retrieve Shareholders Equity Change Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range. When specifying `start_date` and `end_date`, the
#'   interval cannot exceed 10 years. If `end_date` is omitted, it defaults to
#'   the previous Monday per the API specification.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/shareholders-equity-change)
#'
#' @rdname lxr_hk_com_shareholders_equity_change
#' @export
lxr_hk_com_shareholders_equity_change <- make_endpoint(
  endpoint = "hk/company/shareholders-equity-change",
  required = c("token"),
  optional = c("stock_code", "date", "start_date", "end_date", "limit")
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

#' Retrieve Mainland Fund Shareholding Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @details The interval between `start_date` and `end_date` cannot exceed 10 years.
#'   If `end_date` is omitted, it defaults to the previous Monday per the API specification.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/fund-shareholders)
#'
#' @rdname lxr_hk_com_fund_shareholders
#' @export
lxr_hk_com_fund_shareholders <- make_endpoint(
  endpoint = "hk/company/fund-shareholders",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Fund Collection Shareholders Information
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/fund-collection-shareholders)
#'
#' @rdname lxr_hk_com_fund_collection_shareholders
#' @export
lxr_hk_com_fund_collection_shareholders <- make_endpoint(
  endpoint = "hk/company/fund-collection-shareholders",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Dividend Information
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/dividend)
#'
#' @rdname lxr_hk_com_dividend
#' @export
lxr_hk_com_dividend <- make_endpoint(
  endpoint = "hk/company/dividend",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Stock Split Information
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/split)
#'
#' @rdname lxr_hk_com_split
#' @export
lxr_hk_com_split <- make_endpoint(
  endpoint = "hk/company/split",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Allotment Information
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/allotment)
#'
#' @rdname lxr_hk_com_allotment
#' @export
lxr_hk_com_allotment <- make_endpoint(
  endpoint = "hk/company/allotment",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' Retrieve Dividend Reinvestment Return Data
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/tr_dri)
#'
#' @rdname lxr_hk_com_hot_tr_dri
#' @export
lxr_hk_com_hot_tr_dri <- make_endpoint(
  endpoint = "hk/company/hot/tr_dri",
  required = c("token", "stock_codes")
)

#' Retrieve HK Connect (Mutual Market) Data
#'
#' @description Retrieves HK Connect (互联互通) shareholding data. The share capital
#' is calculated as total H-shares.
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/mm_ah)
#'
#' @rdname lxr_hk_com_hot_mm_ah
#' @export
lxr_hk_com_hot_mm_ah <- make_endpoint(
  endpoint = "hk/company/hot/mm_ah",
  required = c("token", "stock_codes")
)

#' Retrieve Repurchase Statistics Data
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/rep)
#'
#' @rdname lxr_hk_com_hot_rep
#' @export
lxr_hk_com_hot_rep <- make_endpoint(
  endpoint = "hk/company/hot/rep",
  required = c("token", "stock_codes")
)

#' Retrieve Short Selling Statistics Data
#'
#' @description Retrieves accumulated short selling data for Hong Kong stocks,
#' including amounts, shares, and H-share ratios over various time periods.
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/ss)
#'
#' @rdname lxr_hk_com_hot_ss
#' @export
lxr_hk_com_hot_ss <- make_endpoint(
  endpoint = "hk/company/hot/ss",
  required = c("token", "stock_codes")
)

#' Retrieve Director Equity Change Statistics Data
#'
#' @description Retrieves director equity change statistics for Hong Kong stocks,
#' including amounts and H-share ratios over various time periods (last transaction,
#' 1/3/6 months, 1/2/3 years).
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/director_equity_change)
#'
#' @rdname lxr_hk_com_hot_director_equity_change
#' @export
lxr_hk_com_hot_director_equity_change <- make_endpoint(
  endpoint = "hk/company/hot/director_equity_change",
  required = c("token", "stock_codes")
)

#' Retrieve Net Profit to Dividend Statistics Data
#'
#' @description Retrieves dividend-related statistics for Hong Kong stocks,
#' including total dividend rate, total net profit, and total dividends since listing.
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/npd)
#'
#' @rdname lxr_hk_com_hot_npd
#' @export
lxr_hk_com_hot_npd <- make_endpoint(
  endpoint = "hk/company/hot/npd",
  required = c("token", "stock_codes")
)

#' Retrieve Per Capita Metrics Statistics Data
#'
#' @description Retrieves per capita metrics statistics for Hong Kong stocks,
#' including per capita market cap, operating income, net profit, and cash flow
#' from operating activities.
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/capita)
#'
#' @rdname lxr_hk_com_hot_capita
#' @export
lxr_hk_com_hot_capita <- make_endpoint(
  endpoint = "hk/company/hot/capita",
  required = c("token", "stock_codes")
)

#' Retrieve Turnover Rate Statistics Data
#'
#' @description Retrieves turnover rate statistics for Hong Kong stocks,
#' including turnover rates for various time periods (1/5/10/20/60/120/240 trading days),
#' along with price change and trading value data.
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/tr)
#'
#' @rdname lxr_hk_com_hot_tr
#' @export
lxr_hk_com_hot_tr <- make_endpoint(
  endpoint = "hk/company/hot/tr",
  required = c("token", "stock_codes")
)

#' Retrieve Short Selling Discount Rate Statistics Data
#'
#' @description Retrieves short selling discount rate statistics for Hong Kong stocks,
#' including current discount rate and average discount rates over various time periods
#' (1 week, 1/3/6 months, 1/2/3 years).
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/hot/ss_ha)
#'
#' @rdname lxr_hk_com_hot_ss_ha
#' @export
lxr_hk_com_hot_ss_ha <- make_endpoint(
  endpoint = "hk/company/hot/ss_ha",
  required = c("token", "stock_codes")
)



#' Retrieve Mutual Market (Stock Connect) Shareholding Data
#'
#' @description Retrieves Stock Connect (互联互通) shareholding data for Hong Kong stocks.
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @details The interval between `start_date` and `end_date` cannot exceed 10 years.
#'   If `end_date` is omitted, it defaults to the previous Monday per the API specification.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=hk/company/mutual-market)
#'
#' @rdname lxr_hk_com_mutual_market
#' @export
lxr_hk_com_mutual_market <- make_endpoint(
  endpoint = "hk/company/mutual-market",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)
