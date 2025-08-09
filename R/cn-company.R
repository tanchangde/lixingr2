#' Get Detailed Stock Information
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @param fs_table_type Financial statement type as a character string. Currently
#'   supported types include: `"non_financial"`, `"bank"`, `"insurance"`,
#'   `"security"`, and `"other_financial"`.
#' @param mutual_markets Stock Connect type as a character string. Currently
#'   supports `"ha"` (Shanghai-Hong Kong Stock Connect).
#' @param include_delisted Whether to include delisted stocks. `FALSE` or
#'   `NULL` means not included.
#'
#' @details If `stock_codes` is not provided, all stock codes will be queried.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company)
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
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/profile)
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
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/equity-change)
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
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/candlestick)
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
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/shareholders-num)
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
#' @inherit common_return return
#'
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range. The `limit` parameter is only effective when
#'   requesting data within a date range.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/senior-executive-shares-change)
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
#' @inherit common_return return
#'
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/major-shareholders-shares-change)
#'
#' @rdname lxr_cn_com_major_shareholders_shares_change
#' @export
lxr_cn_com_major_shareholders_shares_change <- make_endpoint(
  endpoint = "cn/company/major-shareholders-shares-change",
  required = c("token"),
  optional = c("stock_code", "date", "start_date", "end_date", "limit")
)

#' Retrieve Trading Abnormal Data
#'
#' @inheritParams lxr_cn_com_senior_executive_shares_change
#' @inherit common_return return
#'
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/trading-abnormal)
#'
#' @rdname lxr_cn_com_trading_abnormal
#' @export
lxr_cn_com_trading_abnormal <- make_endpoint(
  endpoint = "cn/company/trading-abnormal",
  required = c("token"),
  optional = c("stock_code", "date", "start_date", "end_date", "limit")
)

#' Retrieve Block Deal Data
#'
#' @inheritParams lxr_cn_com_senior_executive_shares_change
#' @inherit common_return return
#'
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/block-deal)
#'
#' @rdname lxr_cn_com_block_deal
#' @export
lxr_cn_com_block_deal <- make_endpoint(
  endpoint = "cn/company/block-deal",
  required = c("token"),
  optional = c("stock_code", "date", "start_date", "end_date", "limit")
)

#' Retrieve Equity Pledge Data
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/pledge)
#'
#' @rdname lxr_cn_com_pledge
#' @export
lxr_cn_com_pledge <- make_endpoint(
  endpoint = "cn/company/pledge",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Revenue Composition Data
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/operation-revenue-constitution)
#'
#' @rdname lxr_cn_com_operation_revenue_constitution
#' @export
lxr_cn_com_operation_revenue_constitution <- make_endpoint(
  endpoint = "cn/company/operation-revenue-constitution",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Operating Data
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/operating-data)
#'
#' @rdname lxr_cn_com_operating_data
#' @export
lxr_cn_com_operating_data <- make_endpoint(
  endpoint = "cn/company/operating-data",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
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
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/indices)
#'
#' @rdname lxr_cn_com_indices
#' @export
lxr_cn_com_indices <- make_endpoint(
  endpoint = "cn/company/indices",
  required = c("token"),
  optional = c("stock_code", "date")
)

#' Retrieve Industry Data
#'
#' @inheritParams lxr_cn_com_indices
#' @inherit lxr_cn_com_indices details
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/industries)
#'
#' @rdname lxr_cn_com_industries
#' @export
lxr_cn_com_industries <- make_endpoint(
  endpoint = "cn/company/industries",
  required = c("token"),
  optional = c("stock_code", "date")
)

#' Retrieve Announcement Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/announcement)
#'
#' @rdname lxr_cn_com_announcement
#' @export
lxr_cn_com_announcement <- make_endpoint(
  endpoint = "cn/company/announcement",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Regulatory Measures Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/measures)
#'
#' @rdname lxr_cn_com_measures
#' @export
lxr_cn_com_measures <- make_endpoint(
  endpoint = "cn/company/measures",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Inquiry Letter Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/inquiry)
#'
#' @rdname lxr_cn_com_inquiry
#' @export
lxr_cn_com_inquiry <- make_endpoint(
  endpoint = "cn/company/inquiry",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Majority Shareholders Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/majority-shareholders)
#'
#' @rdname lxr_cn_com_majority_shareholders
#' @export
lxr_cn_com_majority_shareholders <- make_endpoint(
  endpoint = "cn/company/majority-shareholders",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Top 10 Circulating Shareholders Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/nolimit-shareholders)
#'
#' @rdname lxr_cn_com_nolimit_shareholders
#' @export
lxr_cn_com_nolimit_shareholders <- make_endpoint(
  endpoint = "cn/company/nolimit-shareholders",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Public Fund Shareholders Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fund-shareholders)
#'
#' @rdname lxr_cn_com_fund_shareholders
#' @export
lxr_cn_com_fund_shareholders <- make_endpoint(
  endpoint = "cn/company/fund-shareholders",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Fund Company Shareholders Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fund-collection-shareholders)
#'
#' @rdname lxr_cn_com_fund_collection_shareholders
#' @export
lxr_cn_com_fund_collection_shareholders <- make_endpoint(
  endpoint = "cn/company/fund-collection-shareholders",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Dividend Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/dividend)
#'
#' @rdname lxr_cn_com_dividend
#' @export
lxr_cn_com_dividend <- make_endpoint(
  endpoint = "cn/company/dividend",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Allotment Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/allotment)
#'
#' @rdname lxr_cn_com_allotment
#' @export
lxr_cn_com_allotment <- make_endpoint(
  endpoint = "cn/company/allotment",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Customer Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/customers)
#'
#' @rdname lxr_cn_com_customers
#' @export
lxr_cn_com_customers <- make_endpoint(
  endpoint = "cn/company/customers",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)

#' Retrieve Supplier Information
#'
#' @inheritParams lxr_cn_com_pledge
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/suppliers)
#'
#' @rdname lxr_cn_com_suppliers
#' @export
lxr_cn_com_suppliers <- make_endpoint(
  endpoint = "cn/company/suppliers",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
#' - PE-TTM (ex-NRI) : `d_pe_ttm`
#' - PB : `pb`
#' - PB (ex-Goodwill) : `pb_wo_gw`
#' - PS-TTM : `ps_ttm`
#' - Dividend Yield : `dyr`
#' - PCF-TTM : `pcf_ttm`
#' - EV/EBIT : `ev_ebit_r`
#' - EV/EBITDA : `ev_ebitda_r`
#' - Earnings Yield (E/P) : `ey`
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
#' @inherit common_return return
#'
#' @details The length of `stock_codes` must be between 1 and 100. When assigning
#'   a value to `start_date`, the length of `stock_codes` must be 1. Either
#'   `start_date` or `date` must be provided. `limit` is only effective when
#'   requesting data within a date range. When the length of `stock_codes` is
#'   greater than 1, a maximum of 48 metrics can be selected; when the length of
#'   `stock_codes` equals 1, a maximum of 36 metrics can be retrieved.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/non_financial)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_non_financial(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   date = "2025-07-08",
#'   stock_codes = c("300750", "600519", "600157"),
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y3.cvpos")
#' )
#' }
#'
#' @rdname lxr_cn_com_fundmtl_non_financial
#' @export
lxr_cn_com_fundmtl_non_financial <- make_endpoint(
  endpoint = "cn/company/fundamental/non_financial",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit")
)

#' Retrieve Fundamental Data of Listed Banks
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
#' @inherit common_return return
#' @inherit lxr_cn_com_fundmtl_non_financial details
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/bank)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_bank(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   start_date = "2025-07-01",
#'   end_date = "2025-07-08",
#'   stock_codes = "600036",,
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos")
#' )
#' }
#'
#' @rdname lxr_cn_com_fundmtl_bank
#' @export
lxr_cn_com_fundmtl_bank <- make_endpoint(
  endpoint = "cn/company/fundamental/bank",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit")
)

#' Retrieve Fundamental Data of Listed Securities
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_cn_com_fundmtl
#' @inherit lxr_cn_com_fundmtl_non_financial details
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/security)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_security(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   start_date = "2025-07-01",
#'   end_date = "2025-07-15",
#'   stock_codes = "600030",,
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos")
#' )
#' }
#'
#' @rdname lxr_cn_com_fundmtl_security
#' @export
lxr_cn_com_fundmtl_security <- make_endpoint(
  endpoint = "cn/company/fundamental/security",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit")
)

#' Retrieve Fundamental Data of Listed Insurance
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @param metrics_list A vector of string metrics, e.g., `c("mc", "pe_ttm", "pb", "dyr")`.
#'
#' Currently supported metrics:
#'
#' **Valuation Metrics**
#'
#' - PEV : `pev`
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
#' - PEV : `pev``
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
#' @inherit lxr_cn_com_fundmtl_non_financial details
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/insurance)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_insurance(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   start_date = "2025-07-01",
#'   end_date = "2025-07-15",
#'   stock_codes = "601318",,
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos")
#' )
#' }
#'
#' @rdname lxr_cn_com_fundmtl_insurance
#' @export
lxr_cn_com_fundmtl_insurance <- make_endpoint(
  endpoint = "cn/company/fundamental/insurance",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit")
)

#' Retrieve Other Financial Fundamental Data
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_cn_com_fundmtl
#' @inherit lxr_cn_com_fundmtl_non_financial details
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/other_financial)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_other_financial(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   start_date = "2025-07-01",
#'   end_date = "2025-07-15",
#'   stock_codes = "600901",,
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos")
#' )
#' }
#'
#' @rdname lxr_cn_com_fundmtl_other_financial
#' @export
lxr_cn_com_fundmtl_other_financial <- make_endpoint(
  endpoint = "cn/company/fundamental/other_financial",
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
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fs/non_financial)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fs_non_financial(
#'   token = Sys.getenv("LIXINGR_TOKEN"),
#'   start_date = "2024-07-01",
#'   end_date = "2025-07-01",
#'   stock_codes = "300750",,
#'   metrics_list = "q.ps.toi.t"
#' )
#' }
#'
#' @rdname lxr_cn_com_fs_non_financial
#' @export
lxr_cn_com_fs_non_financial <- make_endpoint(
  endpoint = "cn/company/fs/non_financial",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit")
)
