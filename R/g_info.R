#' Print a warning message to the console.

#' @name g_info
#' @param message  \code{[string]}
#' @param env  \code{[environment]}  Defaults to \code{caller_env()}
#' @return \code{g_info}: [print]
#' @examples

#'  type = 'informative'
#'  g_info('this is a {type} message')
#' @export
g_info <- function(message, env = caller_env()) {
    # Print a warning message to the console
    assert_string(message)
    assert_environment(env)
    cli::cli_alert_info(message, .envir = env)
    # Returns: [print]
}
