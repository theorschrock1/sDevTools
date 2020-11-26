library(sDevTools)
context("checkFunctionUsage")
library(R6)
library(rlang)
test_that("envir = env(one = function(x) {\n    expr(x)\n}, two = function(x) {\n    glue(\"{expr(x)}\")\n}, three = R6::R6Class(\"three\", public = list(four = function(x) {\n    expr(x)\n})))\ncheckFunctionUsage(\"expr\", env = envir, package = \"sDevTools\")", 
    {
        output <- expect_data_table({
            envir = env(one = function(x) {
                expr(x)
            }, two = function(x) {
                glue("{expr(x)}")
            }, three = R6::R6Class("three", public = list(four = function(x) {
                expr(x)
            })))
            checkFunctionUsage("expr", env = envir, package = "sDevTools")
        })
        expect_equal(test_summary(output), list(rows = 3, cols = 4, 
            attributes = list(row.names = 1:3, class = c("data.table", 
                "data.frame"), names = c("obj_name", "type", 
                "symbol_match", "string_match"))))
        expect_equal(test_summary(output[["obj_name"]]), list(N = 3, 
            class = "character", values = c("one", "two", "three:four")))
        expect_equal(test_summary(output[["type"]]), list(N = 3, 
            class = "character", values = "function"))
        expect_equal(test_summary(output[["symbol_match"]]), 
            list(N = 3, class = "logical", values = c(TRUE, FALSE)))
        expect_equal(test_summary(output[["string_match"]]), 
            list(N = 3, class = "logical", values = c(FALSE, 
                TRUE)))
    })
