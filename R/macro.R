#' Retrieve national debt data
#'
#' @inheritParams common_params
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @param area_code Area code, currently supports mainland China: cn, United States: us.
#' @param metrics_list A vector of string metrics.
#'
#'   - Mainland China supports:
#'     - 3-month yield: tcm_m3
#'     - 6-month yield: tcm_m6
#'     - 1-year yield: tcm_y1
#'     - 2-year yield: tcm_y2
#'     - 3-year yield: tcm_y3
#'     - 5-year yield: tcm_y5
#'     - 7-year yield: tcm_y7
#'     - 10-year yield: tcm_y10
#'     - 20-year yield: tcm_y20
#'     - 30-year yield: tcm_y30
#'
#'   - United States supports:
#'     - 3-month yield: tcm_m3
#'     - 6-month yield: tcm_m6
#'     - 1-year yield: tcm_y1
#'     - 2-year yield: tcm_y2
#'     - 3-year yield: tcm_y3
#'     - 5-year yield: tcm_y5
#'     - 7-year yield: tcm_y7
#'     - 10-year yield: tcm_y10
#'     - 20-year yield: tcm_y20
#'     - 30-year yield: tcm_y30
#'
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=macro/national-debt)
#'
#' @rdname lxr_macro_national_debt
#' @export
lxr_macro_national_debt <- make_endpoint(
  endpoint = "macro/national-debt",
  required = c("token", "start_date", "end_date", "area_code", "metrics_list"),
  optional = c("limit")
)

#' Retrieve interest rate data
#'
#' @inheritParams lxr_macro_national_debt
#' @param metrics_list A vector of string metrics. Refer to the API
#'   documentation for the full list of supported metrics.
#'
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=macro/interest-rates)
#'
#' @rdname lxr_macro_interest_rates
#' @export
lxr_macro_interest_rates <- make_endpoint(
  endpoint = "macro/interest-rates",
  required = c("token", "start_date", "end_date", "area_code", "metrics_list"),
  optional = c("limit")
)
