#' Creates an Renviron file with GITHUB_PAT
#'

#' @name use_gitpat_renviron
#' @return \code{use_gitpat_renviron}: NULL
#' @export
use_gitpat_renviron <- function() {
    # Creates an .Renviron file with GITHUB_PAT
    write(readLines(system.file("access/git_pat.txt", package = "sDevTools")),
        ".Renviron")
    restartAndReload()
    # Returns: NULL
}
