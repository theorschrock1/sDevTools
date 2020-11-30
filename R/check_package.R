#' Argument check for a package name.

#' @name check_package
#' @param x  [string]
#' @param null.ok  [logical]  Defaults to FALSE
#' @return \code{check_package}: TRUE is package exists, Message if non-existent
#' @examples

#'  check_package('data.table')
#'  check_package('rlang')
#'  check_package('a_non_existing_package')
#' @export
check_package <- function(x, null.ok = FALSE) {
    # Argument check for a package name
    assert_string(x)
    res <- check_choice(x, installed_packages(), null.ok = null.ok)
    if (!isTRUE(res)) {
        return(glue("package namespace:\"{x}\" not installed"))
    }
    TRUE
    # Returns: TRUE is package exists, Message if non-existent
}
#' @export
assert_package=checkmate::makeAssertionFunction(check_package)
#' @export
check_packages <- function(x, null.ok = FALSE) {
    # Argument check for a package name
    assert_character(x)
    res <- check_subset(x, installed_packages(), empty.ok = null.ok)
    if (!isTRUE(res)) {
        x%NIN%installed_packages()%sep%','
        return(glue("package namespaces:\"{x%NIN%installed_packages()}\" not installed"))
    }
    TRUE
    # Returns: TRUE is package exists, Message if non-existent
}
#' @export
assert_packages=checkmate::makeAssertionFunction(check_packages)
