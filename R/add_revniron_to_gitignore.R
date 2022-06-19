#' Adds.
#'
#' Renviron to .gitignore

#' @name add_revniron_to_gitignore
#' @return \code{add_revniron_to_gitignore}: \code{[NULL]}
#' @export
add_revniron_to_gitignore <- function() {
    # Adds .Renviron to .gitignore
    assert_file_exists(".gitignore")
    lines = readLines(".gitignore")
    if (".Renviron" %in% lines) {
        g_info(".Renviron already present on .gitignore")
        return(invisible(NULL))
    }
    lines <- c(lines, ".Renviron")
    write(lines, ".gitignore")
    g_success(".Renviron added to .gitignore")
    # Returns: \code{[NULL]}
}
