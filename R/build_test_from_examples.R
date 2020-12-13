#' Build a test from existing function examples.

#' @name build_test_from_examples
#' @param fn_name \code{[string]} a function name
#' @param package \code{[package]}  Possible values: c('installed_packages').  Defaults to current_pkg()
#' @param snap \code{[logical(1)]}span test or traditional?
#' @return \code{build_test_from_examples}: NULL
#' @export
build_test_from_examples <- function(fn_name, package = current_pkg(),snap=TRUE) {
    # Build a test from existing function examples
    assert_string(fn_name)
    assert_subset(package, choices = installed_packages())
    assert_logical(snap,len=1)
    tests <- exprs_deparse(list(get_fn_examples(fn_name)))[[1]]
    if(snap){
    tests=glue("build_snapshot_test('{fn_name}',
              code={tests},
              overwrite=TRUE)")
    }else{
    tests=glue("build_test('{fn_name}',
              init=NULL,
              test_code={tests},
              overwrite=TRUE)")
    }
    #backup_current_DEV()

    insertAtCursor(tests)
    # Returns: NULL
}
