# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

lixingr2 is an R package that wraps the Lixinger Open Platform API for financial data (Chinese and Hong Kong stock markets). It uses a factory pattern to generate API endpoint functions.

## Common Commands

```bash
# Load package for interactive development
Rscript -e "devtools::load_all()"

# Build documentation
Rscript -e "devtools::document()"

# Run all tests
Rscript -e "devtools::test()"

# Run tests matching a pattern
Rscript -e "devtools::test(filter = 'factory')"

# Check package (runs R CMD check)
Rscript -e "devtools::check()"
```

## Architecture

### Core Factory Pattern (`R/00-factory.R`)

The package uses a factory pattern to generate API functions:

1. **`new_client()`** - Creates an API client with base URL, headers, and config
2. **`send_request()`** - Low-level HTTP request handler using httr2 with retry logic
3. **`make_endpoint()`** - Factory that generates user-callable API functions

Generated functions automatically:
- Retrieve token from `LIXINGR_TOKEN` env var if not provided
- Convert snake_case params to camelCase for the API
- Handle array vs scalar JSON encoding via `array_params`
- Support multiple return formats: `"json"`, `"list"`, `"tibble"`, `"resp"`

### Adding New Endpoints

Create endpoints using `make_endpoint()`:

```r
lxr_cn_com <- make_endpoint(
  endpoint = "cn/company",
  required = "token",
  optional = c("stock_codes", "fs_table_type"),
  array_params = c("stock_codes")  # These become JSON arrays
)
```

### File Organization

- `R/00-factory.R` - Core factory functions and `lxr_unnest()` helper
- `R/auth.R` - Token management (`lxr_set_token`, `lxr_get_token`)
- `R/batch.R` - `lxr_batch()` for handling >100 stock codes
- `R/cn-company.R`, `R/hk-company.R`, etc. - Domain-specific endpoints
- `R/shared-params-docs.R` - Shared roxygen parameter documentation

### Testing

Tests use `local_mocked_bindings()` to mock httr2 responses. See `tests/testthat/test-00-factory.R` for patterns.

## Commit Message Convention

Follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/). Scopes: `cn-company`, `cn-index`, `cn-industry`, `cn-fund`, `hk-company`, `hk-index`, `hk-industry`, `us-index`, `macro`.

## CI

GitHub Actions runs R-CMD-check on commits prefixed with `build`, `feat`, `fix`, or `test`.
