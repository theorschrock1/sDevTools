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
get_test_names<-
 function(path=getwd()){
   #Documentation
   fdoc("Get test names in a dev package","[character]")
   #Assertions
   assert_directory(path)
   #TO DO
  as_glue(list.files('tests/testthat/',pattern = "\\.[rR]$") %>%
      str_remove_all('test_|\\.[rR]$'))
 }
#document------
 fn_document(get_test_names)
guides()
open_guide("git github.R")
