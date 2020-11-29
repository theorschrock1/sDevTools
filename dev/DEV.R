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
commitPush2Github("mi")
desc_bump_version("dev")
commit(message='added renviron',all=T)
push(credentials =  cred_token())
#Dev -----
commitPush2Github<-
 function(message,push_github=TRUE){
   #Documentation
   fdoc("commit all changes and push to github","[NULL]")
   #Assertions
   assert_string(message)
   assert_logical(push_github, len = 1)
   #TO DO
   desc::desc_bump_version("dev")
   git2r::commit(message=message,all=T)
   if (push_github &
       !file.exists('.Renviron')) {
     warn(
       "Did not push to github.  GIT_HUB PAT not present in .Renviron.  Add this to the current project using use_gitpat_renviron()"
     )
   } else{
    git2r::push(credentials =  git2r::cred_token())
   }
 }
#document------
 fn_document(commitPush2Github)
git2r::add("")
