#' Argument check for a package name.

#' @name check_package
#' @param package  [string]
#' @param null.ok  [logical]  Defaults to FALSE
#' @return \code{check_package}: TRUE is package exists, Message if non-existent
#' @examples

#'  check_package(package = 'data.table')
#'  check_package(package = 'rlang')
#'  check_package(package = 'a_non_existing_package')
#' @export
check_package <- function(package, null.ok = FALSE) {
    # Argument check for a package name
    assert_string(package)
    res <- check_choice(package, installed_packages(), null.ok = null.ok)
    if (!isTRUE(res)) {
        return(glue("package namespace:\"{package}\" not installed"))
    }
    TRUE
    # Returns: TRUE is package exists, Message if non-existent
}
