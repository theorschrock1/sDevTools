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
rebuild_test<-
 function(testname){
   #Documentation
   fdoc("Get a test to rebuid","invisible(NULL) Insert the current test at the cursor")
   #Assertions
   testpath<-path('test_source_files',paste0(testname,'.R'))
   assert_file(testpath)
   #TO DO
   testcode<-parse_file(testpath)
   init=testcode[[2]][[3]]
   test_main=testcode[3:l(testcode)]
   out<-expr_deparse(
   expr(build_test(!!testname,
              init=!!init,
              test_code = {!!!test_main},
              overwrite=TRUE)))%sep%"\n"
   insertAtCursor(text=out,row.offset=2)
 }
#document------
 fn_document(rebuild_test,overwrite = TRUE)

