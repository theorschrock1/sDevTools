#' Print a warning message to the console.

#' @name g_danger
#' @param message  \code{[string]}
#' @param env  \code{[environment]}  Defaults to \code{caller_env()}
#' @return \code{g_danger}: [print]
#' @examples

#'  type = 'dangerous'
#'  g_danger('this is a {type} message')
#' @export
g_danger <- function(message, env = caller_env()) {
    # Print a warning message to the console
    assert_string(message)
    assert_environment(env)
    cli::cli_alert_danger(message, .envir = env)
    # Returns: [print]
}
