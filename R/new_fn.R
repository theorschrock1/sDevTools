#' Create a package function template.

#' @name new_fn
#' @param fn_args  \code{[call]} \code{function_name(...)}
#' @param desc  \code{[string]} what the function does.
#' @param return  \code{[string]} what the function returns.
#' @param type  \code{[choice]}  Possible values: \code{c('standard', 'shiny')}. If shiny, the examples will auto populate with a shiny app template. Defaults to 'standard'.
#' @return \code{new_fn}:\code{[NULL]}
#' @examples

#'  if (interactive()) {
#'  new_fn(
#'     myFunc(
#'       x = numeric(lower = 0, upper = 1),
#'       y = numeric(lower = 0, upper = 1),
#'         na.rm = TF(TRUE)
#'         ),
#'  desc = 'What this function does',
#'  return = 'What this function returns')
#'  }
#' @export
new_fn <- function(fn_args, desc, return, type = "standard") {
    # Create a package function template
    fn_args <- enexpr(fn_args)
    assert_call(fn_args)
    assert_string(desc)
    assert_string(return)
    assert_choice(type, choices = c("standard", "shiny"))
    name = fn_args[[1]]
    fn_args[[1]] <- sym(".")
    dots = fn_args

    asserts=""
    args=""
    if(nnull(names(dots))){
    ae = assert_env()
    assert_names(names(dots)[-1], "unique")
    map(call_args(dots), function(x) assert_call(x, names(ae)))
    dots <- eval(dots, envir = assert_env())
    nms = syms(names(dots))
    asserts <- map2(nms, dots, function(name, call_expr) {
        tmp <- expr_call_modify(call_expr[[2]], x = !!name)
        if (call_expr[[1]] == "=NULL")
            tmp = expr_call_modify(tmp, null.ok = TRUE)
        names(tmp)[2] <- ""
        tmp
    })
    asserts = exprs_deparse(asserts) %sep% "\n   "
    args = unlist(map2(names(dots), dots, function(x, y) paste0(x, y[[1]]))) %sep% ","
    }
    if (type == "standard") {
        examples = fn_example_template(name = name, args = args)
    } else {
        examples = shiny_example_template(name = name, args = args)
    }
    value = cglue("&&name&&<-\n function(&&args&&){\n   #Documentation\n   fdoc(\"&&desc&&\",\"&&return&&\")\n   #Assertions\n   &&asserts&&\n   #TO DO\n    \n }\n#document------\n fn_document(&&name&&,{\n&&examples&&\n })")
    sd = getActiveDocumentContext()
    rowid <- as.numeric(unlist(sd$selection)[1])

    contents <- sd$contents
    start = rowid - which(rev(grepl("new_fn\\(", contents[1:rowid]))) + 1
    end = rowid - 1
    ranges = document_range(document_position(start, 1), document_position(end, Inf))
    newp = which(grepl("#TO DO", str_split(value, "\n")[[1]]))
    modifyRange(location = ranges, text = value)
    setCursorPosition(document_position(start + newp, 4))
    # Returns: [NULL]
}
