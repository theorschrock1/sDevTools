#' Run all tests in the testthat dir of a package.

#' @name runTests
#' @param name \code{[string]} the test name
#' @param package  \code{[string]}  Defaults to current_pkg()
#' @param dev_version \code{[logical(1)]} If true, the test will be run using \code{devtools::load_all()} rather than \code{library(PKG_NAME)}.
#' @return \code{runTests}: [Print(TestResults)]
#' @export
runTests <- function(name=NULL,package = current_pkg(),dev_version=FALSE) {
    # Run all tests in the testthat dir of a package
    assert_string(package)
     if(nnull(name)){
       if(name%ndetect%start_with('test_'))name<-paste0('test_',name)
       file=glue("~/{package}/tests/testthat/{name}.R")
       assert_file_exists(file)
       pathout =glue("~/{package}/tests/testthat/{name}.R")
       testDeps<-expr_glue(library({get_project_testing_deps()}))
       if(dev_version){
         out= run_isolated({
           library(testthat)
           !!!testDeps
           devtools::load_all(quiet=TRUE)
           testthat::test_file(path=!! pathout)
         })

       }else{

         out= run_isolated({
           library(testthat)
           !!!testDeps
           library(!!package,character.only = TRUE)
           testthat::test_file(path=!! pathout)
         })

       }


     }else{
     out= run_isolated({
        devtools::test(package =!!package )
      })
     }

    #if(nnull(out$error))g_stop('{out$error$message}')

     as_glue(out$stdout)
    # Returns: [Print(TestResults)]

}
