#' add a new snapshots to an existing test.
#'
#' Any line without an assignment will be wrapped in \code{expect_snapshot()}.

#' @name add_snapshot_test
#' @param name  \code{[string]} the test name
#' @param code \code{[expr]} the code to test, wrapped in brackets.
#' @return \code{add_snapshot_test}: \code{[invisible(NULL)]} Writes a test file to the tests/thatthat directory
#' @export
add_snapshot_test <- function(name, code) {
# add to a snapshot test
assert_string(name)
code <- enexpr(code)
testpath = glue("tests/testthat/test_{name}.R")
if (!file.exists(testpath)) {

    g_stop("test \"{name}\" does not exist")
}
if (!is_testthat_initialized()) {
  initializeTestthat(test_deps = c("checkmate", "sDevTest"))
}
assert_call(code, call_name = "{")
lines<-wrap_snapshot(call_args(code))

c(name,tests)%<-%call_args(parse_file(testpath)[[1]])

test_code = expr({
  !!!c(call_args(tests),lines)
})
out = expr_deparse(expr(test_that(!!name, !!test_code)))

write(out, testpath)
print(runTests(name, dev_version = TRUE))

return(invisible(NULL))
# Returns: invisible(NULL) Writes a test file to the tests/thatthat directory
}
