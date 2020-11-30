#' Build a test from existing function examples.

#' @name build_test_from_examples
#' @param fn_name a function name
#' @param package  [subset]  Possible values: c('installed_packages').  Defaults to current_pkg()
#' @return \code{build_test_from_examples}: NULL
#' @export
build_test_from_examples <- function(fn_name, package = current_pkg()) {
    # Build a test from existing function examples
    assert_subset(package, choices = installed_packages())
    tests <- exprs_deparse(list(get_fn_examples(fn_name)))[[1]]
    tests=glue("build_test('{fn_name}',
              init=NULL,
              test_code={tests},
              overwrite=TRUE)")
    #backup_current_DEV()
    insertAtCursor(tests)
    # Returns: NULL
}
