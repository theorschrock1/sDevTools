#' Install package.

#' @name install_pkg
#' @param document  [logical]  Defaults to TRUE
#' @return \code{install_pkg}: NULL
#' @export
install_pkg <- function(document = TRUE) {
    # Install package
    assert_logical(document)
    if (document)
        document_pkg()
    devtools::install(upgrade='never')
    # Returns: NULL
}
