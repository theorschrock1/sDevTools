#' Load all package dependencies.

#' @name loadDependencies
#' @param package  [character]  Defaults to current_pkg()
#' @return \code{loadDependencies}: [NULL]
#' @export
loadDependencies <- function(package = current_pkg()) {
    # Load all package dependencies
    load_packages(pkg_deps(package))
    # Returns: [NULL]
}
