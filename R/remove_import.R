#' Remove imports to the current dev package.
#'
#' 

#' @name remove_import
#' @param pkg_names  [character]
#' @return \code{remove_import}: NULL
#' @export
remove_import <- function(pkg_names) {
    # Remove imports to the current dev package.
    assert_character(pkg_names)
    newImprts <- glue("#' @import {pkg_names}")
    utils = readLines("R/utils.R")
    current_imports = str_trim(utils %grep% "#'\\s+\\@import")
    imp = current_imports %NIN% newImprts
    write(c(imp, utils %NIN% current_imports) %sep% "\n", "R/utils.R")
    file.edit("R/utils.R")
    # Returns: NULL
}
