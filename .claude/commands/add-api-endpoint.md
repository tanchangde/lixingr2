Develop API wrapper R packages following R Packages: The Whole Game best practices.

> Chinese version: [add-api-endpoint-zh](./add-api-endpoint-zh.md)

## Prerequisites

- Clear requirements or API documentation URL
- Target module file identified
- Required Token environment variable name (optional)

## Execution Notes

1. **Strict order**: Step 3 (manual verification) must be completed before Step 4 (unit testing)
2. **Wait for confirmation**: All Rterm interactions must wait for `>` prompt before continuing
3. **Parameter reuse**: Prefer parameter patterns from existing endpoints in the same file and API documentation examples
4. **One at a time**: Implement only one API endpoint at a time

## Step 1: API Analysis

### Documentation Retrieval Strategy

1. First try to read the API documentation URL
2. If the content doesn't include API details, use browser to view documentation
3. Scroll to the bottom of the page to extract complete API specifications

### Extraction Checklist

- Request method (GET/POST)
- Required parameters (name, type, format requirements)
- Optional parameters (name, type, default values)
- Response data structure (all fields and their meanings)
- API documentation example parameters

## Step 2: Pattern Analysis & Implementation

### Version Number Decision

- **Major**: Incompatible API changes
- **Minor**: New features (typical scenario for this workflow)
- **Patch**: Bug fixes

### Code Implementation

1. Read target file, identify existing code patterns
2. Write new function in target file:
   - Strictly follow existing wrapper logic
   - Define parameters strictly according to API documentation
   - Write roxygen2 documentation comments, use `@inheritParams` etc.
3. Update DESCRIPTION version number
4. Add test data generation code in `data-raw/`
5. Add unit test code in `tests/testthat/`

## Step 3: Manual Verification & Data Generation

Generate test fixtures through real API calls.

### Parameter Preparation Strategy

1. Prefer example parameters from API documentation
2. Time range parameters: refer to documentation examples or choose reasonable historical intervals
3. Avoid blind guessing, check API documentation first

### Execution Flow

```r
# 1. Start Rterm
Rterm --no-save --no-restore

# 2. Load package
devtools::load_all()

# 3. Create temp file to execute API call (avoid running entire data-raw file)
source("temp-api-call.R", echo = TRUE)

# 4. Verify fixture generated in ./tests/testthat/fixtures/

# 5. Exit and cleanup
q("no")
```

Cleanup temp file: `rm temp-api-call.R` (Linux/Mac) or `del temp-api-call.R` (Windows)

## Step 4: Unit Testing

1. Confirm Step 3 has generated fixture files
2. Add `test_that` blocks in `tests/testthat/`
3. Read fixture data, assert return value structure (class, type, dimensions)
4. Run `devtools::test()`
5. If tests fail, return to Step 3 to adjust parameters and regenerate fixtures

## Step 5: Documentation Generation

```r
devtools::document()
```

Update function help documentation and NAMESPACE.

## Step 6: Final Check

```r
devtools::check()
```

Ensure 0 errors, 0 warnings, 0 notes.

## Common Issues

### API Call Returns Error

1. Check if environment variable (token) is correct
2. Verify parameter format
3. Try different test parameters
4. Check API documentation for endpoint URL

### Test Failures

1. Check if fixture file was successfully generated and non-empty
2. Manually verify fixture data format
3. Compare with test patterns of similar endpoints

### devtools::check() Errors

1. First run `devtools::document()`
2. Check roxygen2 comment format
3. Confirm NAMESPACE exports are consistent
4. Review specific error messages and resolve accordingly

### Rterm Interaction Issues

1. If command is unresponsive, previous step may not be complete, wait longer
2. If function not found, confirm `devtools::load_all()` executed successfully
3. If session is stuck, terminate process and restart Rterm
