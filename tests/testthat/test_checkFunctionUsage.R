test_that("checkFunctionUsage", {
  local_edition(3)
  envir = rlang::env(one = function(x) {
    expr(x)
  }, two = function(x) {
    glue("{expr(x)}")
  }, three = R6::R6Class("three", public = list(four = function(x) {
    expr(x)
  })))
  out <- expect_snapshot(checkFunctionUsage("expr", env = envir,
    package = "sDevTools"), cran = TRUE)
  expect_snapshot(out[], cran = TRUE)
})
