#' Create a custom key board binding.

#' @name newShortCutBinding
#' @param fn  [function]
#' @param name  [string]
#' @param description  [string]
#' @param package  [string]  Defaults to current_pkg()
#' @param interactive  [logical]  Must have an exact length of 1.  Defaults to TRUE
#' @return \code{newShortCutBinding}: NULL
#' @examples
#'  if (interactive()) {
#'  library(praise)
#'  newShortCutBinding(praise, name = 'Say something nice',
#'  description = 'Print a compliment to the console',
#'  package = 'praise', interactive = TRUE)
#'  }
#' @export
newShortCutBinding <- function(fn, name, description, package = current_pkg(),
    interactive = TRUE) {
    # Create a custom key board binding
    fn_name = enexpr(fn)
    assert_function(fn)
    assert_string(name)
    assert_string(description)
    assert_string(package)
    assert_logical(interactive, len = 1)
    inter = "true"
    if (!interactive)
        inter = "false"
    binding <- c(glue("- Name: {name}"), glue("  Description: {description}"),
        glue("  Binding: {package}::{fn_name}"), glue("  Interactive: {inter}"))
    if (!file.exists("~/.config/.shrtcts.yaml")) {
        write(binding %sep% "\n", "~/.config/.shrtcts.yaml")
    } else {
        out <- c(readLines("~/.config/.shrtcts.yaml"), "", binding) %sep%
            "\n"
        write(out %sep% "\n", "~/.config/.shrtcts.yaml")
    }
    shrtcts::add_rstudio_shortcuts()
    rstudioapi::restartSession()
    g_print("Shortcut \"{name}\" installed!\n\nYou can now assign a keyboard shortcut to run your addin.\nSelect from menubar:\n  Tools -> Modify Keyboard Shortcuts")
    # Returns: NULL
}
