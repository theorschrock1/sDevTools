#' Bump the package's version.

#' @name bump_pkg_version
#' @param path  \code{[character]}  Defaults to \code{getwd()}.
#' @return \code{bump_pkg_version}: \code{[invisible(NULL)]}
#' @export
bump_pkg_version <- function(path = getwd()) {
    # Bump the package's version
    assert_file_exists(glue("{path}/DESCRIPTION"))
    oldver <- desc::desc_get_version(file = ".")
    suppressMessages(desc::desc_bump_version("dev"))
    newvar <- desc::desc_get_version(file = ".")
    g_success("Version bumped from '{oldver}' to '{newvar}'")
    # Returns: \code{[invisible(NULL)]}
}
