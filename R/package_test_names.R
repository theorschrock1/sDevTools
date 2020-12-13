#' Get test names in a dev package.

#' @name package_test_names
#' @param path  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{package_test_names}: [character]
#' @export
package_test_names <- function(path = getwd()) {
    # Get test names in a dev package
    assert_directory(path)
    if (!is_testthat_initialized(path)) {
        g_stop("no test directory in dir '{path}'")
    }
    test_files <- list.files(path(path, "tests", "testthat")) %grep% "test_"
    str_remove_all(test_files, "test_|\\.[rR]")
    # Returns: [character]
}
