#' Generate imports.
#'
#' R file for package imports

#' @name generate_imports_file
#' @return \code{generate_imports_file}: [NULL] 
#' @export
generate_imports_file <- function() {
    # Generate imports.R file for package imports
    out = c("", ".onLoad <- function(libname, pkgname) {", "#Do not Remove this function from \"R/Imports.R\"", 
        "}")
    if (file.exists("R/imports.R")) 
        g_stop("R/Imports.R exists")
    write(out, "R/imports.R")
    # Returns: [NULL]
}
