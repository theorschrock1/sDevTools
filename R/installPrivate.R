#' Install a package theorschrock1 github.

#' @name installPrivate
#' @param package  \code{[string]} the package name
#' @return \code{installPrivate}: [NULL]
#' @export
installPrivate <- function(package) {
    # Install a package theorschrock1 github
    assert_string(package)
    devtools::install_github(glue("theorschrock1/{package}"), auth_token = git_token())
    # Returns: [NULL]
}
