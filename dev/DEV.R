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
rox_comments<-
 function(x){
   #Documentation
   fdoc("Create roxygen comments from a string","[character]")
   #Assertions
   assert_character(x)
   #TO DO
   x<-str_splitn(x)
   paste0("#","'"," ",x)
 }
#document------
 fn_document(rox_comments,{
rox_comments(
  'these are roxygen comments
  more comments
  more comments
  @noRd'
  )
 })

