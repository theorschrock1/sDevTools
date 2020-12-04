#' Print a warning message to the console.

#' @name g_warn
#' @param message  \code{[string]}
#' @param env  \code{[environment]}  Defaults to \code{caller_env()}
#' @return \code{g_warn}: [print]
#' @examples

#'  type = 'warning'
#'  g_warn('this is a {type}')
#' @export
g_warn <- function(message, env = caller_env()) {
    # Print a warning message to the console
    assert_string(message)
    assert_environment(env)
    message <- glue(message, .envir = env)
    cli::cli_alert_warning(message)
    # Returns: [print]
}
