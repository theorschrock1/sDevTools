#Check Usage -----
checks=checkPackageUsage()
runTests(package="sDevTools")
#Dismiss Usage Warnings -----
#  suppressUsageWarnings(checks)
###Dev Setup -----
## INSTALL: CTRL + SHIFT + B
sDevTools::clearEnv() ## CTRL + SHIFT + R
sDevTools::loadUtils()
#Dev -----
build_and_reload_gh<-
 function(package=current_pkg(),repo="theorschrock1",auth_token){
   #Documentation
   fdoc("build a package from github","[invisible(NULL)]")
   #Assertions
   assert_package(package)
   assert_string(repo)
   assert_string(auth_token, pattern = "^ghp")
   #TO DO
   remotes::install_github('{repo}/{package}',auth_token = auth_token)
 }
#document------
 fn_document(build_and_reload_gh)



