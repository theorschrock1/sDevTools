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

assert_sdevtools_proj=function(dir=getwd()){
  fdoc("Assert that the current dir is an sDevTools Project.","Throw an error if FALSE")
  assert_directory(dir)
  if(!file.exists('.sDevToolsProj'))
    g_stop("sDevTools has not been initialized in this directory.  Please run sDevTools_initialize().")
}
fn_document(assert_sdevtools_proj)

onAttach<-
 function(code,append=TRUE){
   #Documentation
   fdoc("Add to the package's onAttach function","invisible(NULL) Writes to the onAttach function in the imports.R file.")
   #Assertions
   code=enexpr(code)
   assert_call(code, call_name = "{")
   assert_logical(append, len = 1)
   #TO DO
   if(is_)

 }
#document------
 fn_document(onAttach,{
onAttach(code,append=TRUE)
 })
