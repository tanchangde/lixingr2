#' Retrieve national debt data
#'
#' @inheritParams common_params
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @inheritParams metrics_list_param
#' @param area_code Area code, currently supports mainland China: cn, United States: us.
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
  optional = c("limit"),
  array_params = "metrics_list"
)

#' Retrieve interest rate data
#'
#' @inheritParams lxr_macro_national_debt
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
  optional = c("limit"),
  array_params = "metrics_list"
)

#' Retrieve currency exchange rate data
#'
#' @inheritParams common_params
#' @inheritParams date_range_params
#' @inheritParams limit_param
#' @param from_currency,to_currency Please refer to the API documentation for supported currency pairs.
#'
#' @inherit common_return return
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=macro/currency-exchange-rate)
#'
#' @rdname lxr_macro_fx
#' @export
lxr_macro_fx <- make_endpoint(
  endpoint = "macro/currency-exchange-rate",
  required = c("token", "start_date", "end_date", "from_currency", "to_currency"),
  optional = c("limit")
)
