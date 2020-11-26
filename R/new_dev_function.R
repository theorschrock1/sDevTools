#' Create a new dev function template.

#' @name new_dev_function
#' @param fn_name  [string]
#' @param type [choice('standard'|'shiny')] function template type
#' @param package  [subset]  Possible values: c('installed_packages').  Defaults to current_pkg()
#' @return \code{new_dev_function}: [NULL]
#' @examples

#'  new_dev_function('newfn')
#' @export
new_dev_function <- function(fn_name,...,type='standard', package = current_pkg()) {
    # Create a new dev function template
    assert_string(fn_name)
    assert_choice(type,choices=c("standard","shiny"))

    devDoc(fn_name=fn_name,...,type= type,package=package)
    # Returns: [NULL]
}

