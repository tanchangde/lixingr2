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

## Code Style

Follow the [tidyverse style guide](https://style.tidyverse.org/).

### 1. Naming Conventions

- **Object Names**: Use `snake_case` for all variable and function names
- **Word Choice**: Generally use nouns for variables and verbs for functions
- **Avoid Dots**: Do not use dots (`.`) in names; reserve them exclusively for S3 methods (e.g., `print.data.frame`)
- **File Names**: Use meaningful, `snake_case` names ending in `.R`. If files must run in a specific order, prefix them with numbers (e.g., `01_load.R`, `02_clean.R`)

### 2. Syntax and Layout

- **Assignment**: Always use `<-` for assignment, never `=`. Use `=` only for passing arguments inside functions
- **Line Length**: Limit code to 80 characters per line
- **Indentation**: Use two spaces for indentation. Never use tabs
- **Spacing**:
  - Place spaces around all infix operators (e.g., `+`, `-`, `<-`, `==`)
  - Always put a space after a comma, but never before
  - Do not put spaces inside or outside parentheses for regular function calls (e.g., `mean(x, na.rm = TRUE)`)

### 3. Functional Programming and Pipes

- **Piping**: Use the native pipe `|>` or the magrittr pipe `%>%`
  - Start a new line after every pipe
  - Indent the second line of a pipe sequence by two spaces
- **Function Arguments**: If a function has many arguments, place each on its own line, indented to align with the first argument

### 4. Documentation and Comments

- **Comments**: Use `#` followed by a single space for all comments. For inline comments, use two spaces before the `#`
- **Roxygen2**: Use `#'` for function documentation, following the roxygen2 standard for parameters (`@param`) and return values (`@return`)
- **Sections**: Use commented lines (at least 4 dashes, e.g., `# Load data ----`) to break long scripts into readable sections

### 5. AI-Specific Best Practices

- **Explicit Namespaces**: Use `package::function()` (e.g., `dplyr::mutate()`) to avoid conflicts and improve clarity
- **Styler Integration**: Run the `styler` package before finalizing code to ensure adherence to these rules

## CI

GitHub Actions runs R-CMD-check on commits prefixed with `build`, `feat`, `fix`, or `test`.

## Puppeteer Configuration

When using Puppeteer MCP tools for browser automation, always use the following configuration to preserve login state:

1. First, get the user's home directory by running: `echo $HOME` (or `echo %USERPROFILE%` on Windows CMD)
2. Then use the full expanded path in the launchOptions:

```json
{
  "headless": false,
  "userDataDir": "<expanded_home_dir>/.puppeteer-profile",
  "defaultViewport": null,
  "args": ["--start-maximized"]
}
```

**Important:**
- Always expand `~` or `$HOME` to the actual absolute path before passing to Puppeteer, as tilde expansion may not work correctly.
- `defaultViewport: null` and `--start-maximized` ensure the browser content fills the window.

This ensures login sessions are persisted across browser restarts.
