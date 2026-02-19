#' Get A-Share Index Information
#'
#' @inheritParams common_params
#' @inheritParams stock_codes_param
#' @inherit common_return return
#'
#' @details If `stock_codes` is not provided, all index codes will be queried.
#'
#' @seealso [API documentation](https://www.lixinger.com/open/api/doc?api-key=cn/index)
#'
#' @rdname lxr_cn_index
#' @export
lxr_cn_index <- make_endpoint(
  endpoint = "cn/index",
  required = "token",
  optional = "stock_codes",
  array_params = "stock_codes"
)
