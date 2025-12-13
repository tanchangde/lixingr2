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
  optional = c("stock_codes", "fs_table_type", "mutual_markets", "include_delisted"),
  array_params = c("stock_codes", "mutual_markets")
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
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
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
#' @details The `stock_code` parameter is only effective when requesting data
#'   within a date range.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/candlestick)
#'
#' @rdname lxr_cn_com_candlestick
#' @export
lxr_cn_com_candlestick <- make_endpoint(
  endpoint = "cn/company/candlestick",
  required = "token",
  optional = c(
    "stock_code", "type", "date", "start_date", "end_date",
    "adjust_forward_date", "adjust_backward_date", "limit"
  )
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/indices)
#'
#' @rdname lxr_cn_com_indices
#' @export
lxr_cn_com_indices <- make_endpoint(
  endpoint = "cn/company/indices",
  required = c("token", "stock_code"),
  optional = c("date")
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
  required = c("token", "stock_code"),
  optional = c("date")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
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
#' @inheritParams metrics_list_param
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
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Fundamental Data of Listed Banks
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_param
#'
#' @inherit common_return return
#' @inherit lxr_cn_com_fundmtl_non_financial details
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/bank)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_bank(
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
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Fundamental Data of Listed Securities
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_param
#' @inherit lxr_cn_com_fundmtl_non_financial details
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/security)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_security(
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
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Fundamental Data of Listed Insurance
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_param
#'
#' @inherit lxr_cn_com_fundmtl_non_financial details
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/insurance)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_insurance(
#'   start_date = "2025-07-01",
#'   end_date = "2025-07-15",
#'   stock_codes = "601318",
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos")
#' )
#' }
#'
#' @rdname lxr_cn_com_fundmtl_insurance
#' @export
lxr_cn_com_fundmtl_insurance <- make_endpoint(
  endpoint = "cn/company/fundamental/insurance",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Other Financial Fundamental Data
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_param
#' @inherit lxr_cn_com_fundmtl_non_financial details
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fundamental/other_financial)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fundmtl_other_financial(
#'   start_date = "2025-07-01",
#'   end_date = "2025-07-15",
#'   stock_codes = "600901",
#'   metrics_list = c("pe_ttm", "mc", "pe_ttm.y5.cvpos")
#' )
#' }
#'
#' @rdname lxr_cn_com_fundmtl_other_financial
#' @export
lxr_cn_com_fundmtl_other_financial <- make_endpoint(
  endpoint = "cn/company/fundamental/other_financial",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Financial Statement Data for Non-Financial Listed Companies
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inheritParams date_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_param
#'
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
#'   start_date = "2024-07-01",
#'   end_date = "2025-07-01",
#'   stock_codes = "300750",
#'   metrics_list = "q.ps.toi.t"
#' )
#' }
#'
#' @rdname lxr_cn_com_fs_non_financial
#' @export
lxr_cn_com_fs_non_financial <- make_endpoint(
  endpoint = "cn/company/fs/non_financial",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Financial Statement Data for Listed Banks
#'
#' @inheritParams lxr_cn_com_fs_non_financial
#' @inherit common_return return
#' @inherit lxr_cn_com_fs_non_financial details
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fs/bank)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fs_bank(
#'   start_date = "2024-03-31",
#'   end_date = "2025-03-31",
#'   stock_codes = "600016",
#'   metrics_list = "q.ps.oi.t"
#' )
#' }
#'
#' @rdname lxr_cn_com_fs_bank
#' @export
lxr_cn_com_fs_bank <- make_endpoint(
  endpoint = "cn/company/fs/bank",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Financial Statement Data for Listed Securities Companies
#'
#' @inheritParams lxr_cn_com_fs_non_financial
#' @inherit common_return return
#' @inherit lxr_cn_com_fs_non_financial details
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fs/security)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fs_security(
#'   start_date = "2024-03-31",
#'   end_date = "2025-03-31",
#'   stock_codes = "600030",
#'   metrics_list = "q.ps.oi.t"
#' )
#' }
#'
#' @rdname lxr_cn_com_fs_security
#' @export
lxr_cn_com_fs_security <- make_endpoint(
  endpoint = "cn/company/fs/security",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Financial Statement Data for Listed Insurance Companies
#'
#' @inheritParams lxr_cn_com_fs_non_financial
#' @inherit common_return return
#' @inherit lxr_cn_com_fs_non_financial details
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fs/insurance)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fs_insurance(
#'   start_date = "2024-03-31",
#'   end_date = "2025-03-31",
#'   stock_codes = "601318",
#'   metrics_list = "q.ps.oi.t"
#' )
#' }
#'
#' @rdname lxr_cn_com_fs_insurance
#' @export
lxr_cn_com_fs_insurance <- make_endpoint(
  endpoint = "cn/company/fs/insurance",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve Financial Statement Data for Listed Other Financial Companies
#'
#' @inheritParams lxr_cn_com_fs_non_financial
#' @inherit common_return return
#' @inherit lxr_cn_com_fs_non_financial details
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/company/fs/other_financial)
#'
#' @examples
#' \dontrun{
#' lxr_cn_com_fs_other_financial(
#'   start_date = "2024-03-31",
#'   end_date = "2025-03-31",
#'   stock_codes = "600901",
#'   metrics_list = "q.ps.oi.t"
#' )
#' }
#'
#' @rdname lxr_cn_com_fs_other_financial
#' @export
lxr_cn_com_fs_other_financial <- make_endpoint(
  endpoint = "cn/company/fs/other_financial",
  required = c("token", "stock_codes", "metrics_list"),
  optional = c("date", "start_date", "end_date", "limit"),
  array_params = c("stock_codes", "metrics_list")
)

#' Retrieve A-Share Popularity Data
#'
#' * `lxr_cn_com_hot_tr_dri()` retrieves dividend reinvestment yield data.
#' * `lxr_cn_com_hot_mm_ha()` retrieves Stock Connect data.
#' * `lxr_cn_com_hot_mtasl()` retrieves margin trading and securities lending data.
#' * `lxr_cn_com_hot_esc()` retrieves senior executive shareholding change data.
#' * `lxr_cn_com_hot_mssc()` retrieves major shareholder shareholding change data.
#' * `lxr_cn_com_hot_t_a()` retrieves trading abnormality data.
#' * `lxr_cn_com_hot_elr()` retrieves restricted shares unlocking data.
#' * `lxr_cn_com_hot_ple()` retrieves equity pledge data.
#' * `lxr_cn_com_hot_capita()` retrieves per capita indicators data.
#' * `lxr_cn_com_hot_shnc()` retrieves shareholder number change data.
#' * `lxr_cn_com_hot_df()` retrieves dividend financing data.
#' * `lxr_cn_com_hot_npd()` retrieves dividend distribution data.
#' * `lxr_cn_com_hot_tr()` retrieves turnover rate data.
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_tr_dri <- make_endpoint(
  endpoint = "cn/company/hot/tr_dri",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_mm_ha <- make_endpoint(
  endpoint = "cn/company/hot/mm_ha",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_mtasl <- make_endpoint(
  endpoint = "cn/company/hot/mtasl",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_esc <- make_endpoint(
  endpoint = "cn/company/hot/esc",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_mssc <- make_endpoint(
  endpoint = "cn/company/hot/mssc",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_t_a <- make_endpoint(
  endpoint = "cn/company/hot/t_a",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_elr <- make_endpoint(
  endpoint = "cn/company/hot/elr",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_ple <- make_endpoint(
  endpoint = "cn/company/hot/ple",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_capita <- make_endpoint(
  endpoint = "cn/company/hot/capita",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_shnc <- make_endpoint(
  endpoint = "cn/company/hot/shnc",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_df <- make_endpoint(
  endpoint = "cn/company/hot/df",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_npd <- make_endpoint(
  endpoint = "cn/company/hot/npd",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' @rdname lxr_cn_com_hot
#' @export
lxr_cn_com_hot_tr <- make_endpoint(
  endpoint = "cn/company/hot/tr",
  required = c("token", "stock_codes"),
  array_params = "stock_codes"
)

#' Retrieve Capital Flow Data
#'
#' * `lxr_cn_com_mutual_market()` retrieves Stock Connect data.
#' * `lxr_cn_com_mtasl_history()` retrieves historical margin trading and
#'   securities lending data.
#'
#' @inheritParams common_params
#' @inheritParams stock_code_param
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inherit common_return return

#' @rdname lxr_cn_com_capital_flow
#' @export
lxr_cn_com_mutual_market <- make_endpoint(
  endpoint = "cn/company/mutual-market",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)

#' @rdname lxr_cn_com_capital_flow
#' @export
lxr_cn_com_mtasl_history <- make_endpoint(
  endpoint = "cn/company/margin-trading-and-securities-lending",
  required = c("token", "stock_code", "start_date"),
  optional = c("end_date", "limit")
)
