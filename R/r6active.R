#' insert an R6 active template into the editor.

#' @name r6active
#' @param name the R6 class name
#' @param read_only  \code{[logical]}  Defaults to \code{T}
#' @return \code{r6active}: NULL
#' @export
r6active <- function(name, read_only = T) {
    # insert an R6 active template into the editor
    assert_logical(read_only)
    name <- enexpr(name) %>% as_string()
    if (read_only)
        ro = glue("stop(\"{name} is read only\")")
    out = glue("&&name&&=function(value){\n\tif(missing(value)){\n\t return()\n\t}\n\t&&ro&&\n  \n   }",
        .open = "&&", .close = "&&")
    replaceLastLine(tidy_source(text = out)[[1]], insert_at_col = 5, require_selection = TRUE)
    # Returns: NULL
}
