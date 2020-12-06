#' Get names of untested function in a dev package.

#' @name untested_package_fns
#' @param path  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{untested_package_fns}: [character]
#' @export
untested_package_fns <- function(path = getwd()) {
    # Get names of untested function in a dev package
    assert_directory(path)
    package_fn_names(path) %NIN% package_test_names()
    # Returns: [character]
}
