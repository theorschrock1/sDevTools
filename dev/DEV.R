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
test_named_list<-
 function(x,y){
   #Documentation
   fdoc("test","test")
   #Assertions
   assert_named_list(x, structure = list(x = char(), y = string()))
   assert_reactive(y, output_type = "named_list", structure = list(x = char(),
    y = string()))
   #TO DO

 }
#document------
 fn_document(test_named_list)



add
