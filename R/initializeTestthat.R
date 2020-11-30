#' Initialize testthat and build test directories in the working directory.

#' @name initializeTestthat
#' @param test_deps  \code{[package]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{initializeTestthat}: invisible(NULL)
#' @export
initializeTestthat <- function(test_deps = NULL) {
    # Initialize testthat and build test directories in the working directory
    assert_package(test_deps, null.ok = TRUE)
    if (!is_testthat_initialized()) {
        usethis::use_testthat()
        dir.create("test_source_files")
        g_success("Test creation files will be stored in 'test_source_files/'")
    }
    df <- readLines("tests/testthat.R")
    adddepstest <- c(df %grep% "library(testtest)", glue("library({test_deps})"), df[!grepl("library", 
        df)])
    write(adddepstest, "tests/testthat.R")
    g_success("packages:'{test_deps%sep%','}' testing dependencies added")
    invisible(NULL)
    # Returns: invisible(NULL)
}
