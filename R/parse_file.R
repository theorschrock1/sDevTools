#' Parse an r file.

#' @name parse_file
#' @param path  \code{[file_exists]}
#' @param split \code{[logical(1)]} split into a list of expressions? Defaults to \code{TRUE}.
#' @return \code{parse_file}: \code{[list(exprs)|expr]} unevaluated R expression or list of expressions.
#' @export
parse_file <- function(path,split=TRUE) {
    # Parse an r file
    assert_file_exists(path, extension = c("R", "r"))
    assert_logical(split,len=1)
    lines <- c("{", readLines(path), "}") %sep% "\n"
    out<-parse_expr(lines)
    if(!split)return(out)
    call_args(out)
    # Returns: [list(exprs)] unevalualted R expression
}
