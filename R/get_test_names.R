#' Get test names in a dev package.

#' @name get_test_names
#' @param path  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{get_test_names}: \code{[character]}
#' @export
get_test_names <- function(path = getwd()) {
    # Get test names in a dev package
    assert_directory(path)
    as_glue(list.files("tests/testthat/", pattern = "\\.[rR]$") %>% str_remove_all("test_|\\.[rR]$"))
    # Returns: \code{[character]}
}
