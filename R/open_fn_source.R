#' Open a function source file.

#' @name open_fn_source
#' @param fn_name  \code{[string]}
#' @return \code{open_fn_source}: invisible(null)
#' @export
open_fn_source <- function(fn_name) {
    # Open a function source file
    assert_string(fn_name)
    files <- paste0("R/", list.files("R/"))
    src = files[sapply(files, is_fn_in_R_file, fn_name = fn_name)]
    if (l(src) == 0) 
        g_stop("\"{fn_name}\" not found in package: \"{current_pkg()}\"")
    if (l(src) > 1) 
        g_stop("function name found in multiple files:\n{src%sep%'\n'}")
    lines = str_trim(readLines(src))
    cursor <- which(grepl(start_with(fn_name), lines))
    if (l(cursor) == 0) 
        cursor = 1
    navigateToFile(src, line = cursor[1])
    # Returns: invisible(null)
}
