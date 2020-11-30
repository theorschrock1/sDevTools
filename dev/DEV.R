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

open_fn_source=function(fn_name){
  fdoc("Open a function source file","invisible(null)")
  assert_string(fn_name)
  files<- paste0("R/",list.files('R/'))
  src=files[sapply(files,is_fn_in_R_file,fn_name=fn_name)]

  if(l(src)==0)g_stop('"{fn_name}" not found in package: "{current_pkg()}"')
  if(l(src)>1)g_stop("function name found in multiple files:\n{src%sep%'\n'}")
  lines=str_trim(readLines(src))
  cursor<-which(grepl(start_with(fn_name),lines))
  if(l(cursor)==0)cursor=1
  navigateToFile(src,line=cursor[1])
}

fn_document(open_fn_source,overwrite = TRUE)
