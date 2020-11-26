#' Get function examples from documentation.

#' @name get_fn_examples
#' @param fn_name  [file_exists]
#' @return \code{get_fn_examples}: [expr(examples)]
#' @export
get_fn_examples <- function(fn_name) {
    # Get function examples from documentation
    if (!str_detect(fn_name, ends_with("\\.[rR]"))) 
        fn_name <- paste0(fn_name, ".R")
    fn_name = paste0("R/", fn_name)
    assert_file_exists(fn_name)
    lines <- readLines(fn_name)
    start = which(grepl("@examples", lines)) + 1
    end = which(grepl("@export", lines)) - 1
    examples <- lines[start:end] %NIN% ""
    examples <- c("{", str_trim(str_remove_all(examples, "#'")), "}") %sep% "\n"
    parse_expr(examples)
    # Returns: [expr(examples)]
}
