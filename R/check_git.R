#' Check if a directory is using GIT.

#' @name check_git
#' @param dir  \code{[string]}  Defaults to \code{getwd()}
#' @return \code{check_git}: TRUE if using git, character message if not using git
#' @examples

#'  check_git(getwd())
#' @export
check_git <- function(dir = getwd()) {
    # Check if a directory is using GIT
    assert_string(dir)
    res = is_dir_using_git(dir = dir)
    if (!res)
        return(glue("{dir} is not using GIT.  use create_github_repo() to initiatize git for an R project."))
    res
    # Returns: TRUE if using git, character message if not using git
}
#' @export
assert_git<-checkmate::makeAssertionFunction(check_git)
