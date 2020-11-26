#' Load a vector of package names.

#' @name load_packages
#' @param pkgs  [subset]  Possible values: c('installed_packages').
#' @return \code{load_packages}: [invisible(NULL)]
#' @export
load_packages <- function(pkgs) {
    # Load a vector of package names
    assert_subset(pkgs, choices = installed_packages())
    lapply(pkgs, function(x) library(x, character.only = TRUE))
    return(invisible(NULL))
    # Returns: [invisible(NULL)]
}
