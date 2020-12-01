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



onPackageLoad<-
 function(code,append=TRUE,message=NULL,package=getwd()){
   #Documentation
   fdoc("Add functionality to the package's onLoad process","invisible(NULL) Writes to the .onLoad function in the imports.R file.")
   #Assertions
   code=enexpr(code)
   assert_call(code, call_name = "{")
   assert_logical(append, len = 1)
   assert_string(message, null.ok=TRUE)
   assert_sdevtools_proj(package)
   #TO DO
   if (!file.exists("R/imports.R")) {
     generate_imports_file()
   }
   im_fns<-parse_file("R/imports.R")
   onLoadIndex=which(sapply(im_fns,function(x){
     if(!is_assignment(x))return(FALSE)
     x[[2]]==".onLoad"
   }))
   if(l(onLoadIndex)>1)
     g_stop("multiple .onLoad function in 'R/imports.R' file.  Please remove the duplicate")
   onLd<-im_fns[[onLoadIndex]]
   if(!(len0(onLd))&&append){
     current<- call_args(onLd[[3]][[3]])
     code<- expr({!!!c(current,call_args(code))})
   }
     im_fns[[onLoadIndex]]<-expr({
       .onLoad <- function(libname, pkgname) !!code
     })[[2]]
     current=readLines('R/imports.R')
     out<-c( current%grep%"#'\\s+\\@import","",current%grep%"# This","",
     exprs_deparse(im_fns)%sep%"\n\n")
     write(out,'R/imports.R')
     if(is.null(message)){
       g_success(".onLoad function modified. See 'R/imports.R'")
     }else{
       g_success(message)
     }
     return(invisible(NULL))
 }
#document------
 fn_document(onPackageLoad)

onPackageLoad({bs_global_theme()})
