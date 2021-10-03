#' build a package from github.

#' @name build_and_reload_gh
#' @param package  \code{[package]}  Defaults to \code{current_pkg()}
#' @param repo  \code{[string]}  Defaults to \code{'theorschrock1'}
#' @param auth_token  \code{[string]}  All non-missing elements must comply to regex pattern \code{'''^ghp'''}.
#' @return \code{build_and_reload_gh}: \code{[invisible(NULL)]}
#' @export
build_and_reload_gh <- function(package = current_pkg(), repo = "theorschrock1",
    auth_token=git_token(TRUE)) {
    # build a package from github
    assert_package(package)
    assert_string(repo)
    assert_string(auth_token, pattern = "^ghp")
    remotes::install_github(glue("{repo}/{package}"), auth_token = auth_token)
    # Returns: \code{[invisible(NULL)]}
}
