#' insert an R6 skeleton into the editor.

#' @name r6skeleton
#' @param name  \code{[string]}  Defaults to \code{'TmpName'}
#' @param inherits  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{r6skeleton}: NULL
#' @export
r6skeleton <- function(name = "TmpName", inherits = NULL) {
    # insert an R6 skeleton into the editor
    assert_string(name)
    assert_string(inherits, null.ok = TRUE)
    if (is.null(inherits)) {
        out <- glue("&&name&& = R6Class(\n  '&&name&&',\n  public = list(\n    initialize = function() {\n\n    }\n  ),\n  private = list(),\n  active = list()\n)", 
            .open = "&&", .close = "&&")
    } else {
        out <- glue("&&name&& = R6Class(\n  '&&name&&',\n  inherit=&&inherits&&,\n  public = list(\n    initialize = function(...) {\n    self$super_init(...)\n    },\n    super_init=import_fn(super_init)\n  ),\n  private = list(),\n  active = list()\n)", 
            .open = "&&", .close = "&&")
    }
    replaceLastLine(out)
    # Returns: NULL
}
