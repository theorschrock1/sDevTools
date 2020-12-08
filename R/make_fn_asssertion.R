#' Make assertion for a new function.

#' @name make_fn_asssertion
#' @param dots  \code{[call]}  Must be a call from function \code{'.'}.
#' @return \code{make_fn_asssertion}: \code{[list(exprs)]}
#' @examples

#'  x = expr(.(id = string(), name = string(), env = env(caller_env),
#'  args = named_list(structure = list(x = num(), y = num()))))
#'  make_fn_asssertion(x)
#' @export
make_fn_asssertion <- function(dots) {
    # Make assertion for a new function
    assert_call(dots, call_name = ".")
    ae = get_assert_env()
    assert_names(names(dots)[-1], "unique")
    map(call_args(dots), function(x) assert_call(x, names(ae)))
    dotstmp = lapply(call_args(dots), function(x) {
        if (any(names(x) %in% "structure")) 
            x$structure[[1]] = sym("list_structure")
        x
    })
    dots = expr(.(!!!dotstmp))
    dots <- eval(dots, envir = get_assert_env())
    nms = syms(names(dots))
    asserts <- map2(nms, dots, function(name, call_expr) {
        tmp <- expr_call_modify(call_expr[[2]], x = !!name)
        if (call_expr[[1]] == "=NULL") 
            tmp = expr_call_modify(tmp, null.ok = TRUE)
        names(tmp)[2] <- ""
        tmp
    })
    return(asserts)
    # Returns: \code{[list(exprs)]}
}
