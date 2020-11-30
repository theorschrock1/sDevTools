#' Retieve packages that should be load before running test.

#' @name get_project_testing_deps
#' @param dir  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{get_project_testing_deps}: [character]
#' @export
get_project_testing_deps <- function(dir = getwd()) {
    # Retieve packages that should be load before running test
    assert_directory(dir)
    if (!dir.exists(paste0(dir, "/tests/"))) 
        g_stop("testing directory doesn't exist. Initialize testthat using sDevTools::initializeTestthat()")
    readLines(path(dir, "tests", "testthat.R")) %grep% "library\\(\\w+\\)" %NIN% 
        "library(testthat)" %>% str_extract(any_inside("\\(", "\\)"))
    # Returns: [character]
}
