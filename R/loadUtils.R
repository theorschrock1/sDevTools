#' Load any file ending with utils.R into the global environment.

#' @name loadUtils
#' @return \code{loadUtils}: NULL
#' @export
loadUtils <- function() {
    # Load the utils functions into the global environment

    utils<- paste0("R/",list.files('R/',pattern='utils\\.R|utils\\.r'))
    if (len0(utils))
        return("No Utils files.")
    for (i in  utils){
    exprs_eval(parse_file(i), env = parent.frame(2))
    }
    # Returns: NULL
}
