#' Add, commit, and push all changes to github.

#' @name commit_all_to_github
#' @param path  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{commit_all_to_github}: \code{[invisible(NULL)]}
#' @export
commit_all_to_github <- function(path = getwd()) {
    # Add, commit, and push all changes to github
    assert_directory(path)
    git_message <- bump_pkg_version(path)
    git2r::add(path = ".")
    commitPush2Github(git_message, push_github = is_internet_connected(), bump_version = FALSE)
    invisible(NULL)
    # Returns: \code{[invisible(NULL)]}
}
