#' Parse an r file.

#' @name parse_file
#' @param path  [file_exists]
#' @return \code{parse_file}: [list(exprs)] unevalualted R expression
#' @export
parse_file <- function(path) {
    # Parse an r file
    assert_file_exists(path, extension = c("R", "r"))
    lines <- c("{", readLines(path), "}") %sep% "\n"
    call_args(parse_expr(lines))
    # Returns: [list(exprs)] unevalualted R expression
}
