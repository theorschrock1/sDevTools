#' Detect a name reference in an function or object.

#' @name obj_detect_name
#' @param obj
#' @param name  \code{[string]}
#' @return \code{obj_detect_name}: data.table(obj_name,type,symbol_match,string_match)
#' @examples

#'  fn = function(x) {
#'  map(x, function(x) glue('the sum is {sum(x)}'))
#'  }
#'  obj_detect_name(fn, name = 'map')
#'  obj_detect_name(fn, name = 'sum')
#' @export
obj_detect_name <- function(obj, name) {
    # Detect a name reference in an function or object
    assert_string(name)
    fn_name <- as_string(enexpr(obj))
    if (!is_function(obj)) {
        out = list(data.table(symbol_match = FALSE, string_match = FALSE, type = class(obj)[1]))
        names(out) = fn_name
        return(out)
    }
    fn_expr <- expr({
        !!sym(fn_name) <- !!obj
    })
    x <- call_args(parse_expr(c("{", as.character(fn_expr)[2], "}") %sep% "\n"))[[1]][[3]]
    outsym = expr_detect_name(x = x, name = name, search_in_strings = FALSE)
    outstr = expr_detect_name(x = x, name = name, search_in_strings = TRUE)
    out = list(data.table(symbol_match = outsym, string_match = outstr, type = class(obj)[1]))
    names(out) = fn_name
    out
    # Returns: data.table(obj_name,type,symbol_match,string_match)
}
