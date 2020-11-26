#' Get package dependencies.

#' @name pkg_deps
#' @param package  [subset]  Possible values: c('installed_packages').  Defaults to current_pkg()
#' @return \code{pkg_deps}: [character]
#' @export
pkg_deps <- function(package = current_pkg()) {
    # Get package dependencies
    assert_subset(package, choices = installed_packages())
    env <- as.environment(getNamespace(package))
    names(env$.__NAMESPACE__.$imports)%NIN%""
    # Returns: [character]
}
