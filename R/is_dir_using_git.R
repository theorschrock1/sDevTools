#' Check if a directory is using GIT.

#' @name is_dir_using_git
#' @param dir  \code{[string]}  Defaults to \code{getwd()}
#' @return \code{is_dir_using_git}: [Logical(1)]
#' @examples

#'  is_dir_using_git(getwd())
#' @export
is_dir_using_git <- function(dir = getwd()) {
    # Check if a directory is using GIT
    assert_string(dir)
    dir.exists(paste0(dir, "/.git"))
    # Returns: [Logical(1)]
}
