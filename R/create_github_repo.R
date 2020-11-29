#' Initializes git / github repo for the current project.

#' @name create_github_repo
#' @return \code{create_github_repo}: [NULL]
#' @export
create_github_repo <- function() {
    # Initializes git / github repo for the current project
    usethis::use_git(message = "Initial commit")
    usethis::use_github(private = TRUE, protocol = "https", credentials = NULL,
        auth_token = git_token(), host = NULL)
    use_gitpat_renviron()
    # Returns: [NULL]
}
