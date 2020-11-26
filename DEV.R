###Dev Setup -----
library(sDevTools)

loadDependencies()
loadUtils()
###Check Usage -----
wn<-checkPackageUsage()
###Dismiss Usage Warnings -----

 #  suppressUsageWarnings(wn)

###Dev ----

new_dev_function=function(fn_name,package=current_pkg()){
  if(!dir.exists('depreciated'))
    dir.create('depreciated')
  if(!dir.exists('depreciated/oldDevs'))
    dir.create('depreciated/oldDevs')
  if(file.exists('dev/DEV.R'))
    file.copy('dev/DEV.R',glue('depreciated/oldDevs/DEV-{Sys.time()}.R'))
  tmp <- readLines(paste0(system.file(package = "sDevTools"), "/templates/DEV_newfn.R")) %sep%
    "\n"

  tmp = cglue(tmp)
  write(tmp, file = "dev/DEV.R")
  file.edit("dev/DEV.R")
}

fn_document(new_dev_function,{
  new_dev_function("newfn")
})


