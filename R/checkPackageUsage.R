#' Check the usage of all function internals in a package in an isolated environment.
#'
#'

#' @name checkPackageUsage
#' @param package  [choice]  NULL is ok.  Defaults to NULL
#' @param dev_version  [logical] Should the check be run in the dev version \code{devtools::load_all()} or installed version \code{library(PKG_NAME)}?
#' @param hide_suppressed [logical] Hide usage issues that have been suppressed? Defaults to \code{TRUE}.
#' @return \code{checkPackageFns}: TRUE if no issues were found, otherwise a table of potential issues.
#' @export
checkPackageUsage <- function(package = NULL,dev_version=TRUE,hide_suppressed=TRUE) {
    # Check the usage of all function internals in a package in an
    # isolated environment.

    assert_choice(package, installed_packages(), null.ok = TRUE)
    if (is.null(package))
        package = sUtils::last(stringr::str_split(getwd(), "/")[[1]])
    if(dev_version){
    body = expr({
        devtools::load_all()
        codetools::checkUsagePackage(!!package)
        devtools::unload()
    })
    }else{
        body = expr({
            library(!!package)
            codetools::checkUsagePackage(!!package)
            devtools::unload()
        })
    }
    fn = rlang::new_function(args = NULL, body = body)
    rs <- callr::r_session$new( wait = TRUE,wait_timeout = 5000)
    outs <- rs$run_with_output(fn)
    rs$close(grace = 1000)

    if(!is.null(outs$error))
        g_stop(outs$error$message)


   tmp<-print_usage(outs$stdout,package=package,hide_suppressed=hide_suppressed)
   if (isTRUE(tmp))
       return(TRUE)
   class(tmp)<-c("usage_warning",class(tmp))
   invisible(tmp)
    # Returns: TRUE if no issues were found, otherwise a table of
    # potential issues.
}

