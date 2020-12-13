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
commit_all_to_github<-
 function(path=getwd()){
   #Documentation
   fdoc("Add, commit, and push all changes to github","[invisible(NULL)]")
   #Assertions
   assert_directory(path)
   #TO DO
   git_message<-bump_pkg_version(path)
   git2r::add(path='.')
   commitPush2Github(git_message,
                     push_github = is_internet_connected(),
                     bump_version = FALSE)
 }

#document------
 fn_document(commit_all_to_github,{
commit_all_to_github(path=getwd())
 })
