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
#' @seealso [API documentation](https://open.lixinger.com/api/cn/company/shareholders-num)
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
#'   within a date range.
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
#' @seealso [API documentation](https://open.lixinger.com/api/cn/company/major-shareholders-shares-change)
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
#' @seealso [API documentation](https://open.lixinger.com/api/cn/company/trading-abnormal)
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
#' @seealso [API documentation](https://open.lixinger.com/api/cn/company/block-deal)
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
#' @seealso [API documentation](https://open.lixinger.com/api/cn/company/pledge)
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
#' @seealso [API documentation](https://open.lixinger.com/api/cn/company/operation-revenue-constitution)
#'
#' @rdname lxr_cn_com_operation_revenue_constitution
#' @export
lxr_cn_com_operation_revenue_constitution <- make_endpoint(
  endpoint = "cn/company/operation-revenue-constitution",
  required = c("token"),
  optional = c("stock_code", "start_date", "end_date", "limit")
)
