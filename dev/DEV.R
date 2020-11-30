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
initializeTestthat<-
 function(test_deps=NULL){
   #Documentation
   fdoc("Initialize testthat and build test directories in the working directory","invisible(NULL)")
   #Assertions
   assert_package(test_deps, null.ok = TRUE)
   #TO DO
   if(!is_testthat_initialized()) {
     usethis::use_testthat()
     dir.create("test_source_files")
     g_success("Test creation files will be stored in 'test_source_files/'")
   }
   df<-readLines('tests/testthat.R')

   adddepstest<-c(df%grep%"library(testtest)",
                  glue('library({test_deps})'),
                  df[!grepl('library',df)])

   write(adddepstest,'tests/testthat.R')
   g_success("packages:'{test_deps%sep%','}' testing dependencies added")

   invisible(NULL)
 }
#document------
 fn_document(initializeTestthat)
