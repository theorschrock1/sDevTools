#Check Usage -----
checks=checkPackageUsage()
runTests(package="sDevTools")
#Dismiss Usage Warnings -----
#  suppressUsageWarnings(checks)
###Dev Setup -----
## INSTALL: CTRL + SHIFT + B
sDevTools::clearEnv() ## CTRL + SHIFT + R
library(sDevTools)
loadUtils()
#Dev -----
initializeShinyPackage<-
  function(package_name=current_pkg()){
    #Documentation
    fdoc("Creates a template for developing shiny packages","invisible(NULL) Creates R files 'R/run_app.R', 'R/app_ui.R', 'R/app_server.R','R/app_ui_utils.R','R/app_server_utils.R,'R/app_config.R' and create dir 'inst/app/www'.")
    #Assertions
    assert_string(package_name)
    #TO DO
    if(file.exists('.RSHINYPACKAGE'))
      g_stop('shiny package has already been initialized for {getwd()}')
    write('','.RSHINYPACKAGE')

    file='R/run_app.R'
    if (!file.exists(file)) {
      write(devRunApp(), file)
      g_success("writing '{file}'")
    }
    file='R/app_ui.R'
    if (!file.exists(file)) {
      write(devAppUi(), file)
      g_success("writing '{file}'")
    }
    file='R/app_server.R'
    if (!file.exists(file)) {
      write(devAppServer(), file)
      g_success("writing '{file}'")
    }
    file='R/app_ui_utils.R'
    if (!file.exists(file)) {
      write(devAppUiUtils(), file)
      g_success("writing '{file}'")
    }
    file='R/app_server_utils.R'
    if (!file.exists(file)) {
      write(devAppServerUtils(), file)
      g_success("writing '{file}'")
    }
    file='R/app_config.R'
    if (!file.exists(file)) {
      write(devAppConfig(), file)
      g_success("writing '{file}'")
    }

    if(!dir.exists('inst/app/www'))
      createAppDir()
      g_success("Creating 'inst/app/www' directories")
    import_pkg(c('shiny','htmltools',"ShinyReboot","bootstraplib"))
  }
#document------
fn_document(initializeShinyPackage)
