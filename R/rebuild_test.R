#' Get a test to rebuid.

#' @name rebuild_test
#' @param testname
#' @return \code{rebuild_test}: invisible(NULL) Insert the current test at the cursor
#' @export
rebuild_test <- function(testname) {
    # Get a test to rebuid
    testpath <- path("test_source_files", paste0(testname, ".R"))
    assert_file(testpath)
    testcode <- parse_file(testpath)
    init = testcode[[2]][[3]]
    test_main = testcode[3:l(testcode)]
    out <- expr_deparse(expr(build_test(!!testname, init = !!init, test_code = {
        !!!test_main
    }, overwrite = TRUE))) %sep% "\n"
    insertAtCursor(text = out, row.offset = 2)
    # Returns: invisible(NULL) Insert the current test at the cursor
}
