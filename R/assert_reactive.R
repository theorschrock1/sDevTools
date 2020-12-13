#' assert if an object is a reactive expression.

#' @name assert_reactive

#' @param x an R object to check
#' @param output_type  \code{[string]} The type of the output with the reactive expression is called. NULL is ok.  Defaults to \code{NULL}
#' @param ... additional params to pass onto the type assertion
#' @return \code{assert_reactive}: TRUE if valid, message if invalid
#' @examples

#'  if (interactive()) {
#'  mod_ui <- function(id) {
#'  ns <- NS(id)
#'  tagList()
#'  }
#'  mod_server <- function(id, x) {
#'  moduleServer(id, function(input, output, session) {
#'  ns <- session$ns
#'  x <- assert_reactive(id, x,output_type = 'character')
#'  observe({
#'  print(x())
#'  })
#'  })
#'  }
#'  library(shiny)
#'  ui <- fluidPage(tags$h1('mod'), )
#'  server <- function(input, output, session) {
#'  t <- reactive({
#'  1
#'  })
#'  mod_server('test', x = t)
#'  }
#'  shinyApp(ui, server)
#'  }
#' @importFrom shiny reactive
#' @export
assert_reactive <- function(x, output_type = NULL, ...,.m=NULL) {
    # check if an object is a reactive expression
    v_collect()

    assert_string(output_type, null.ok = TRUE)
    res <- is(x, "reactiveExpr")
    dots = enexprs(...)
    if (!isTRUE(res)) {
        g_stop("{.x} must be a reactive expression")
    }
    if (nnull(output_type)) {
        assert <- eval(expr_glue("expr(check_{output_type}(x(),!!!dots))")[[1]])
        return(reactive({
            message <- eval(assert)
            fn_name <- ""
            if(!is.null(.m)){
                fn_name <- glue(" for '{.m}'")
            }
            if (!isTRUE(message)) g_stop("invalid reactive input{fn_name}:\n  '{.x}' {message} ")
            invisible(x())
        }))
    }
    return(invisible(reactive({x()})))
    # Returns: X invisibly if valid
}


# module_id = function(env = caller_env()) {
#     get('id', envir = env)
# }
