#' Get object names in a dev package.

#' @name package_fn_names
#' @param path  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{package_fn_names}: [character]
#' @export
package_fn_names <- function(path = getwd()) {
    # Get object names in a dev package
    assert_directory(path)
    names(package2list(path = path))
    # Returns: [character]
}
