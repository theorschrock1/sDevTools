#' Print a success message to the console.

#' @name g_success
#' @param message  \code{[string]}
#' @param env  \code{[environment]}  Defaults to \code{caller_env()}
#' @return \code{g_success}: [NULL]
#' @examples

#'  g_success('Success')
#' @export
g_success <- function(message, env = caller_env()) {
    # Print a success message to the console
    assert_string(message)
    assert_environment(env)
    cli::cat_bullet(glue(message, .envir = env), bullet = "tick", bullet_col = "green")
    # Returns: [NULL]
}
