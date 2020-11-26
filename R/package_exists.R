#' Check if a package exists.

#' @name package_exists
#' @param pkg  [string]
#' @return \code{package_exists}: [Logical(1)]
#' @examples

#'  package_exists('data.table')
#' @export
package_exists <- function(pkg) {
    # Check if a package exists
    assert_string(pkg)
    pkg %in% installed_packages()
    # Returns: [Logical(1)]
}
