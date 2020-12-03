#Check Usage -----
checks=checkPackageUsage()
runTests(package="sDevTools")
#Dismiss Usage Warnings -----
#  suppressUsageWarnings(checks)
###Dev Setup -----
## INSTALL: CTRL + SHIFT + B
sDevTools::clearEnv() ## CTRL + SHIFT + R
library(sDevTools)
sDevTools::loadUtils()
#Dev -----
code=expr({
  x=expr(data[,.(sum_mpg=sum(mpg,na.rm=FALSE),mean_mpg=mean(mpg,na.rm=),max_mpg=max(mpg)),by=.(vs)])

  expr_modify_fn_args(x,new_args=list(na.rm=TRUE),call_name='sum')
  expr_modify_fn_args(x=x,new_args=list(na.rm=TRUE))
  expr_modify_fn_args(x=x,new_args=list(na.rm=TRUE),modify_if_present = FALSE)

})
fn_name<-'expr_modify_fn_args'
build_snapshot_test<-
 function(fn_name,code,commit_git=TRUE,push_github=TRUE){
   #Documentation
   fdoc("Build a snapshot test","invisible(NULL) Writes a test file to the tests/thatthat directory")
   #Assertions
   assert_string(fn_name)
   assert_logical(commit_git,len=1)
   assert_logical(push_github,len=1)
   code<-enexpr(code)
   if(!is_testthat_initialized()){
     initializeTestthat(test_deps=c("checkmate","sDevTest"))
   }
   assert_call(enexpr(code), call_name = "{")
   #TO DO
   find<-expr_extract_call(code,fn_name)
   if(len0(find)){
     g_stop("function '{fn_name}' not found in code")
   }
   replacement<-lapply(find,function(x)expr(expect_snapshot(!!x,cran=TRUE)))

   test_code<-expr_find_replace_all(find, replacement,code,match.first = TRUE)

    test_code=expr({!!!c(expr(local_edition(3)),call_args(test_code))})
    out=expr_deparse(expr(test_that(!!fn_name,!!test_code)))
    testpath=glue('tests/testthat/test_{fn_name}.R')
    write(out, testpath)
    print(runTests(fn_name,dev_version = TRUE))
    snaps<-paste0('tests/testthat/_snaps/',list.files('tests/testthat/_snaps/',pattern=fn_name))
    n <- readline(prompt="Keep Test? Enter 1 for yes: ")
    if(isTRUE(n!=1)){
      file.remove(testpath)
      g_success('test file "{testpath}" deleted')

      if(nlen0(snaps))
        invisible(lapply(snaps,file.remove))
      g_success('snap file "{snaps}" deleted')
      g_stop("testing aborted")
    }

    if(is_dir_using_git()&commit_git){
      add2Git(file=c(testpath, snaps),message="added tests for '{fn_name}'",push=push_github,bump_version = FALSE)
    }
    return(invisible(NULL))
 }
#document------
 fn_document(build_snapshot_test)



build_snapshot_test(fn_name = 'g_success',
                    code={
                      g_success('Success')
                      your_name="Bob"
                      g_success('Your name is {your_name}')
                      },commit_git = TRUE)
code=expr({
  g_success('Success')
  your_name="Bob"
  g_success('Your name is {your_name}')
})
library(testthat)

skip_on_cran()
out= run_isolated({
  sDevTools::loadUtils()
  testthat::test_file(path=glue('tests/testthat/test-g_success.R'))
})
glue(out$stdout)
Sys.getenv("NOT_CRAN")
import_pkg('curl')



