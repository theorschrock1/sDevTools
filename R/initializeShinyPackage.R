#' Creates a template for developing shiny packages.

#' @name initializeShinyPackage
#' @param package_name  \code{[string]}  Defaults to \code{current_pkg()}
#' @param force \code{[logical(1)]} force initialization if a shiny package as already been initialized? Defaults to \code{[FALSE]}.
#' @return \code{initializeShinyPackage}: invisible(NULL) Creates R files 'R/run_app.R', 'R/app_ui.R', 'R/app_server.R','R/app_ui_utils.R','R/app_server_utils.R,'R/app_config.R' and create dir 'inst/app/www'.
#' @export
initializeShinyPackage <- function(package_name = current_pkg(),force=FALSE) {
    # Creates a template for developing shiny packages
    assert_string(package_name)
    if (file.exists(".RSHINYPACKAGE")&force==FALSE)
        g_stop("shiny package has already been initialized for {getwd()}")
    write("", ".RSHINYPACKAGE")
    file = "R/run_app.R"
    if (!file.exists(file)) {
        write(devRunApp(), file)
        g_success("writing '{file}'")
    }
    file = "R/app_ui.R"
    if (!file.exists(file)) {
        write(devAppUi(), file)
        g_success("writing '{file}'")
    }
    file = "R/app_server.R"
    if (!file.exists(file)) {
        write(devAppServer(), file)
        g_success("writing '{file}'")
    }
    file = "R/app_ui_utils.R"
    if (!file.exists(file)) {
        write(devAppUiUtils(package_name=package_name), file)
        g_success("writing '{file}'")
    }
    file = "R/app_server_utils.R"
    if (!file.exists(file)) {
        write(devAppServerUtils(), file)
        g_success("writing '{file}'")
    }
    file = "R/app_config.R"
    if (!file.exists(file)) {
        write(devAppConfig(package_name=package_name), file)
        g_success("writing '{file}'")
    }
    if (!dir.exists("inst/app/www"))
        createAppDir()
    g_success("Creating 'inst/l]]
              lf/www' directories")
    import_pkg(c("shiny", "htmltools", "ShinyReboot", "bslib"))
    onPackageLoad({  bslib::bs_global_theme()},message = "Adding bootstrap 3+4 theme to package's .onLoad function")
    if(!file.exists("udb.rds")){
    saveRDS(enterApp$new(),"udb.rds")
    g_success("Creating user login database 'udb.rds'.")
    g_info("Initial username='user' password='pw'. Reset this using set_default_app_user_pass()")
    }
    # Returns: invisible(NULL)
    return(invisible(NULL))
    # Creates R files 'R/run_app.R', 'R/app_ui.R', 'R/app_server.R','R/app_ui_utils.R','R/app_server_utils.R,'R/app_config.R' and create dir 'inst/app/www'.
}
