#' Generate imports.
#'
#' R file for package imports

#' @name generate_imports_file
#' @return \code{generate_imports_file}: [NULL]
#' @export
generate_imports_file <- function() {
    # Generate imports.R file for package imports
    out = c("","# This script is intended for imports and .onLoad/.onAttach functions only.  Do not add other functions to this file or remove existing.","", ".onLoad <- function(libname, pkgname) {","",
        "}")
    if (file.exists("R/imports.R"))
        g_stop("R/Imports.R exists")
    write(out, "R/imports.R")
    # Returns: [NULL]
}
