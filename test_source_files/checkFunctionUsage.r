library(sDevTools)
init <- {
    library(R6)
    library(rlang)
}
envir = env(one = function(x) {
    expr(x)
}, two = function(x) {
    glue("{expr(x)}")
}, three = R6::R6Class("three", public = list(four = function(x) {
    expr(x)
})))
checkFunctionUsage("expr", env = envir, package = "sDevTools")
