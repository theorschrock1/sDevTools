#' Launch a shiny app package.

#' @name launch_app
#' @param package  \code{[package]}  Defaults to \code{current_pkg()}
#' @return \code{launch_app}: \code{[invisible(NULL)]}
#' @export
launch_app <- function(package = current_pkg()) {
    # Launch a shiny app package
    assert_package(package)
    if (!file.exists(path(getwd(), "R", "run_app.R"))) 
        g_stop("\"run_app.R\" not found")
    clear_env_load_all()
    eval(parse_expr(glue("{current_pkg()}::run_app(user = \"user\",pw =\"pw\")")))
    # Returns: \code{[invisible(NULL)]}
}
