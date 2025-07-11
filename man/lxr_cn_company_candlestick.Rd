% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cn-company.R
\name{lxr_cn_company_candlestick}
\alias{lxr_cn_company_candlestick}
\title{Retrieve Candlestick Data}
\usage{
lxr_cn_company_candlestick(
  token,
  stock_code,
  type,
  start_date,
  end_date = NULL,
  adjust_forward_date = NULL,
  adjust_backward_date = NULL,
  limit = NULL,
  .max_tries = getOption("lxg.max_tries", 4L),
  .backoff_fun = getOption("lxg.backoff_fun", NULL),
  .retry_on = getOption("lxg.retry_on", NULL)
)
}
\arguments{
\item{token}{Authentication token, must be a character string.}

\item{stock_code}{A single stock code as a character string, e.g., "300750".}

\item{type}{Adjustment type, e.g., "lxr_fc_rights". Supported types include:
No adjustment: \code{ex_rights}, Lixinger pre-adjustment: \code{lxr_fc_rights},
Pre-adjustment: \code{fc_rights}, Post-adjustment: \code{bc_rights}.}

\item{start_date}{The start date as a character string in "YYYY-MM-DD" format.
The date should be based on Beijing Time (UTC+8).}

\item{end_date}{The end date as a character string in "YYYY-MM-DD" format.
If not provided, the default value is last Monday. The interval between
the start and end dates must not exceed 10 years. The date should be based
on Beijing Time (UTC+8).}

\item{adjust_forward_date}{The starting date for pre-adjustment as a character string.
Must be used with \code{end_date} and must be greater than or equal to \code{end_date}.
Required when requesting adjusted data; defaults to \code{end_date} if not provided.}

\item{adjust_backward_date}{The starting date for post-adjustment as a character string.
Must be used with \code{start_date} and must be less than or equal to \code{start_date}.
Required when requesting adjusted data; defaults to \code{start_date} if not provided.}

\item{limit}{The number of latest records to return. This parameter is only
effective when requesting data within a date range.}

\item{.max_tries}{Maximum number of retry attempts. Can be set via option
"lxg.max_tries". Default is 4.}

\item{.backoff_fun}{Function to calculate backoff delay in seconds between
retries. Default is an exponential backoff with jitter. The delay increases
with the number of retry attempts and includes randomness to reduce conflicts.
The maximum delay is capped at 10 seconds. Can be set via option "lxg.backoff_fun".}

\item{.retry_on}{Predicate function that takes a single argument (the
response) and returns TRUE or FALSE to specify whether the response
represents a transient error that should trigger a retry. Default retries
on HTTP status codes 429 (Too Many Requests) and 500+ (Server Errors).
Can be set via option "lxg.retry_on".}
}
\value{
A parsed API response list. For details, refer to the
\href{https://www.lixinger.com/open/api/doc?api-key=cn/company/candlestick}{API文档}。
}
\description{
Adjusted prices are calculated only for the selected time period,
while trading volume is not adjusted.
}
