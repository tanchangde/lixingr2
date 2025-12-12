## ----include = FALSE----------------------------------------------------------
library(lixingr2)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  eval = identical(Sys.getenv("NOT_CRAN"), "true") && lxr_has_token()
)

## ----install, eval = FALSE----------------------------------------------------
# # Install from GitHub
# pak::pkg_install("tanchangde/lixingr2")

## ----set-token, eval = FALSE--------------------------------------------------
# library(lixingr2)
# 
# # Set Token
# lxr_set_token("your-api-token")
# 
# # Check if Token is set
# lxr_has_token()

## ----env-token, eval = FALSE--------------------------------------------------
# # Edit .Renviron file
# usethis::edit_r_environ()
# 
# # Add the following line and save:
# # LIXINGR_TOKEN=your-api-token
# 
# # Restart R session to take effect

## ----basic-info---------------------------------------------------------------
# library(lixingr2)
# 
# # Get basic info for CATL
# stocks <- lxr_cn_com(stock_codes = "300750")
# stocks

## ----profile------------------------------------------------------------------
# # Get company profile
# profile <- lxr_cn_com_profile(stock_codes = "300750")
# profile

## ----candlestick--------------------------------------------------------------
# # Get candlestick data for Kweichow Moutai
# candlestick <- lxr_cn_com_candlestick(
#   stock_code = "600519",
#   start_date = "2024-01-01",
#   end_date = "2024-01-31",
#   limit = 1,
#   type = "lxr_fc_rights"  # Lixinger forward-adjusted
# )
# candlestick

## ----financial----------------------------------------------------------------
# # Get fundamental data for non-financial companies
# fundmtl <- lxr_cn_com_fundmtl_non_financial(
#   stock_codes = "600519",
#   metrics_list = c("pe_ttm", "pb", "ps_ttm", "dyr"),
#   date = "2025-12-02"
# )
# fundmtl

## ----return-format-tibble-----------------------------------------------------
# result_tibble <- lxr_cn_com(
#   stock_codes = "600519",
#   options = list(call_config = list(return_format = "tibble"))
# )
# result_tibble

## ----return-format-json-------------------------------------------------------
# result_json <- lxr_cn_com(
#   stock_codes = "600519",
#   options = list(call_config = list(return_format = "json"))
# )
# result_json

## ----return-format-resp-------------------------------------------------------
# result_resp <- lxr_cn_com(
#   stock_codes = "600519",
#   options = list(call_config = list(return_format = "resp"))
# )
# result_resp

## ----token-management, eval = FALSE-------------------------------------------
# # Set Token
# lxr_set_token("your-token")
# 
# # Get current Token
# token <- lxr_get_token()
# 
# # Check if Token exists
# lxr_has_token()
# 
# # Clear Token
# lxr_clear_token()

