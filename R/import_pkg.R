#' Add imports to the current dev package.
#'
#'

#' @name import_pkg
#' @param pkg_names  [subset]  Possible values: c('installed_packages').
#' @return \code{import_pkg}: NULL
#' @export
import_pkg <- function(pkg_names,open=FALSE) {
    # Add imports to the current dev package.
    assert_subset(pkg_names, choices = installed_packages())
    lapply(pkg_names, usethis::use_package)
    newImprts <- glue("#' @import {pkg_names}")
    g_success("Adding imports '{pkg_names%sep%','}' to DESCRIPTION file")
    if (!file.exists("R/imports.R")) {
        generate_imports_file()
    }
    utils = readLines("R/imports.R")
    current_imports = str_trim(utils %grep% "#'\\s+\\@import")
    imp = unique(c(current_imports, newImprts))
    utils=c(imp, utils %NIN% imp) %sep% "\n"
    write(  utils, "R/imports.R")
    g_success("Addings packages '{pkg_names%sep%','}' to 'imports.R")
    if(open){
    file.edit("R/imports.R")
    }
    # Returns: NULL
}
