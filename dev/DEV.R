#Check Usage -----
checks=checkPackageUsage()
runTests(package="sDevTools")
#Dismiss Usage Warnings -----
#  suppressUsageWarnings(checks)
###Dev Setup -----
## INSTALL: CTRL + SHIFT + B
sDevTools::clearEnv() ## CTRL + SHIFT + R
library(sDevTools)
loadDependencies()
loadUtils()
#Dev -----
get_project_testing_deps<-
 function(dir=getwd()){
   #Documentation
   fdoc("Retieve packages that should be load before running test","[character]")
   #Assertions
   assert_directory(dir)
   #TO DO
   if(!dir.exists(paste0(dir,"/tests/")))
     g_stop("testing directory doesn't exist. Initialize testthat using sDevTools::initializeTestthat()")
   readLines(path(dir, 'tests', 'testthat.R')) %grep%
     "library\\(\\w+\\)" %NIN%
     "library(testthat)" %>%
      str_extract(any_inside("\\(", "\\)"))
 }
#document------
 fn_document(get_project_testing_deps)
