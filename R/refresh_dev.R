#' Clear the current dev file.

#' @name refresh_dev
#' @param package  [subset]  Possible values: c('installed_packages').  Defaults to current_pkg()
#' @return \code{refresh_dev}: [NULL]
#' @examples

#'  refresh_dev()
#' @export
refresh_dev <- function(package = current_pkg()) {
    # Clear the current dev file
    assert_subset(package, choices = installed_packages())

    devDoc(package = package )
    # Returns: [NULL]
}
