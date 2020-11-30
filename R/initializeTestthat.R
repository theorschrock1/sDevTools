#' Initialize testthat and build test directories in the working directory.

#' @name initializeTestthat
#' @param test_deps  \code{[package]} Any packages that should be loaded before tests are ran. If project is a package, the package name in the working directory is automatically loaded.  NULL is ok.  Defaults to \code{NULL}
#' @return \code{initializeTestthat}: invisible(NULL)
#' @export
initializeTestthat <- function(test_deps = NULL) {
    # Initialize testthat and build test directories in the working directory
    assert_packages(test_deps, null.ok = TRUE)
    if (!is_testthat_initialized()) {
        usethis::use_testthat()
        dir.create("test_source_files")
        g_success("Test creation files will be stored in 'test_source_files/'")
        if(is_dir_using_git()){
            add2Git('tests/testthat.R',commit=TRUE)
            add2Git('tests/testthat/',commit=TRUE)
            add2Git('test_source_files/',commit=TRUE)
            g_success("Tests added to GIT")
         }
    }
    df <- readLines("tests/testthat.R")
    adddepstest <- c(df %grep% "library(testtest)", glue("library({test_deps})"), df[!grepl("library",
        df)])
    write(adddepstest, "tests/testthat.R")
    g_success("packages:'{test_deps%sep%','}' testing dependencies added")


    invisible(NULL)
    # Returns: invisible(NULL)
}
