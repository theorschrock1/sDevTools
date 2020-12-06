#' list functions in a dev package.

#' @name package2list
#' @param path  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{package2list}: [list(exprs)]
#' @export
package2list <- function(path = getwd()) {
    # list functions in a dev package
    assert_directory(path)
    rfiles <- paste0(path, "/R/", list.files(path(path, "R")))
    lapply(rfiles, function(x) {
        fx <- parse_file(x)
        if (len0(fx)) 
            return(NULL)
        expr_assignment_to_list(fx)
    }) %>% reduce(c)
    # Returns: [list(exprs)]
}
