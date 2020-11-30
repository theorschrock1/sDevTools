#' create a file path to an install R package.

#' @name package_file
#' @param package  \code{[string]}
#' @param path  \code{[string]}
#' @return \code{package_file}: [character(file_path)]
#' @export
package_file <- function(package, path) {
    # create a file path to an install R package
    assert_string(package)
    assert_string(path)
    system.file(path, package = package)
    # Returns: [character(file_path)]
}
