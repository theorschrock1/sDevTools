#' Load all non-exported functions into the package environment

#' @name loadUtils
#' @return \code{loadUtils}: NULL
#' @export
loadUtils <- function() {
    # Load the utils functions into the global environment
    devtools::load_all(quiet=TRUE,helpers=FALSE)
    # utils<- paste0("R/",list.files('R/',pattern='utils\\.R|utils\\.r'))
    # if (len0(utils))
    #     return("No Utils files.")
    # for (i in  utils){
    # exprs_eval(parse_file(i), env = parent.frame(2))
    # }
    # Returns: NULL
}
