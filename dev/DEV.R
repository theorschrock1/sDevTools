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
add_revniron_to_gitignore<-
 function(){
   #Documentation
   fdoc("Adds .Renviron to .gitignore","[NULL]")
   #Assertions

   #TO DO
   assert_file_exists('.gitignore')
   lines=readLines('.gitignore')
   if('.Renviron' %in%lines){

     g_info('.Renviron already present on .gitignore')
     return(invisible(NULL))
   }

     lines<-c(lines,'.Renviron')
     write(lines,'.gitignore')
     g_success('.Renviron added to .gitignore')
 }
#document------
 fn_document(add_revniron_to_gitignore)
