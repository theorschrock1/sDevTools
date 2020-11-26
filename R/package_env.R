#' Get a packages enviromnent.

#' @name package_env
#' @param package  \code{[subset]}  Possible values: \code{installed_packages()}.  Defaults to \code{current_pkg()}
#' @return \code{package_env}: [Environment]
#' @export
package_env <- function(package = current_pkg()) {
    # Get a packages enviromnent
    assert_subset(package, choices = installed_packages())
    as.environment(glue("package:{package}"))
    # Returns: [Environment]
}
