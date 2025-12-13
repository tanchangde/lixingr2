#' Batch Request Helper
#'
#' Automatically splits large stock code requests into batches to handle
#' API limitations (max 100 codes per request).
#'
#' @section Supported Functions:
#' This function only works with API functions that:
#' - Accept a `stock_codes` parameter (plural, not `stock_code`)
#' - Support querying multiple stock codes in a single request
#'
#' Compatible functions include: `lxr_cn_com`, `lxr_cn_com_profile`,
#' `lxr_cn_com_fundmtl_*`, `lxr_cn_com_fs_*`, `lxr_cn_com_hot_*`,
#' `lxr_hk_com`, `lxr_hk_com_fundmtl_*`, etc.
#'
#' Functions using `stock_code` (singular) like `lxr_cn_com_candlestick`
#' are NOT supported.
#'
#' @section Return Format:
#' This function always returns a tibble by forcing `return_format = "tibble"`.
#' Any `return_format` specified in `options` will be overridden.
#' If you need other formats (`json`, `list`, `resp`), iterate over chunks manually.
#'
#' @param stock_codes Character vector of stock codes.
#' @param fn API function to call (e.g., `lxr_cn_com`).
#' @param batch_size Maximum codes per request (default: 100).
#' @param delay Delay between requests in seconds (default: 0.1).
#' @param max_retries Maximum retry attempts per failed batch (default: 2).
#' @param .progress Show progress bar (default: TRUE).
#' @param ... Additional arguments passed to `fn`.
#'
#' @return A tibble combining all batch results.
#' @export
#'
#' @examples
#' \dontrun{
#' # Query 500 stocks
#' codes <- sprintf("%06d", 1:500)
#' result <- lxr_batch(
#'   stock_codes = codes,
#'   fn = lxr_cn_com
#' )
#' }
lxr_batch <- function(stock_codes,
                      fn,
                      batch_size = 100L,
                      delay = 0.1,
                      max_retries = 2L,
                      .progress = TRUE,
                      ...) {
  # ── Parameter validation ─────────────────────────────────────────
  if (!is.character(stock_codes) || length(stock_codes) == 0) {
    cli::cli_abort(c(
      "{.arg stock_codes} must be a non-empty character vector",
      "x" = "Received: {.cls {class(stock_codes)}} of length {length(stock_codes)}"
    ))
  }

  if (!is.function(fn)) {
    cli::cli_abort(c(
      "{.arg fn} must be a function",
      "x" = "Received: {.cls {class(fn)}}"
    ))
  }

  # Capture extra arguments and force return_format = "tibble"
  extra_args <- list(...)
  extra_args$options <- utils::modifyList(
    extra_args$options %||% list(),
    list(call_config = list(return_format = "tibble"))
  )

  # ── Chunking ─────────────────────────────────────────────────────
  n_codes <- length(stock_codes)
  chunks <- split(stock_codes, ceiling(seq_len(n_codes) / batch_size))
  n_chunks <- length(chunks)

  # Fast path for single batch
  if (n_chunks == 1L) {
    return(do.call(fn, c(list(stock_codes = stock_codes), extra_args)))
  }

  # ── Batch processing ─────────────────────────────────────────────
  # Helper: execute single batch with retry logic
  execute_batch <- function(chunk, batch_idx) {
    result <- NULL

    for (attempt in seq_len(max_retries + 1L)) {
      if (!is.null(result)) break

      result <- tryCatch(
        do.call(fn, c(list(stock_codes = chunk), extra_args)),
        error = function(e) {
          if (attempt <= max_retries) {
            cli::cli_alert_warning(
              "Batch {batch_idx} attempt {attempt} failed: {conditionMessage(e)}"
            )
            Sys.sleep(delay * attempt)  # Exponential backoff
          }
          NULL
        }
      )
    }

    if (is.null(result)) {
      cli::cli_warn(c(
        "Batch {batch_idx} failed after {max_retries + 1} attempts",
        "i" = "First 3 codes: {.val {head(chunk, 3)}}"
      ))
    }

    result
  }

  # Process all batches using for loop (cli progress works better with for)
  results <- vector("list", n_chunks)

  if (.progress) {
    cli::cli_progress_bar(
      format = paste0(
        "{cli::pb_spin} Batch {cli::pb_current}/{cli::pb_total} ",
        "[{cli::pb_bar}] {cli::pb_percent} | ETA: {cli::pb_eta}"
      ),
      total = n_chunks,
      clear = FALSE
    )
  }

  for (i in seq_len(n_chunks)) {
    results[[i]] <- execute_batch(chunks[[i]], i)

    if (.progress) cli::cli_progress_update()

    # Delay between batches (except for last batch)
    if (delay > 0 && i < n_chunks) Sys.sleep(delay)
  }

  if (.progress) cli::cli_progress_done()

  # ── Combine results ──────────────────────────────────────────────
  results <- purrr::compact(results)

  if (length(results) == 0) {
    cli::cli_abort(c(
      "All {n_chunks} batches failed",
      "i" = "Check your network connection and API token"
    ))
  }

  n_failed <- n_chunks - length(results)
  if (n_failed > 0) {
    cli::cli_alert_info(
      "Successfully processed {length(results)}/{n_chunks} batches"
    )
  }

  dplyr::bind_rows(results)
}
