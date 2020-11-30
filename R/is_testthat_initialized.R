#' Test if test that is initialized in a dir.

#' @name is_testthat_initialized
#' @param dir  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{is_testthat_initialized}: Logical(1)
#' @export
is_testthat_initialized <- function(dir = getwd()) {
    # Test if test that is initialized in a dir
    assert_directory(dir)
    "./tests/testthat" %in% list.dirs()
    # Returns: Logical(1)
}
