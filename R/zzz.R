if (getRversion() >= "2.15.1") {
  utils::globalVariables(
    c(".max_tries", ".backoff_fun", ".retry_on", ".return_format")
  )
}
