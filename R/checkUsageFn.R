#' Check the usage of fn internals in an isolated package environment.
#'
#'

#' @name checkUsageFn
#' @param fn  [function]
#' @param fn_name  [string] Optional string indicating the function's name. Defaults to NULL.
#' @param dev_version  [logical] Should the check be run in the dev version \code{devtools::load_all()} or installed version \code{library(PKG_NAME)}?
#' @param package  [choice]  NULL is ok.  Defaults to current_pkg()
#' @return \code{checkUsageFn}: TRUE if no issues were found, otherwise a table of potential issues.
#' @examples

#'  fn <- function(x) {

#'  f(s, x)

#'  }

#'  checkUsageFn(fn, 'sDevTools')

#' @export
checkUsageFn <- function(fn,fn_name=NULL,dev_version=TRUE, package =current_pkg()) {
    # Check the usage of fn internals in an isolated package
    # environment.
    if(is.null(fn_name)){
      fn_name<-expr(fn)
      if(is(fn_name,'name'))
        fn_name=as_string(fn_name)
    }
    assert_function(fn)
    assert_choice(package, installed_packages(), null.ok = TRUE)
    assert_string(fn_name,null.ok = TRUE)
        body = expr({
            if(dev_version){
                devtools::load_all()
            }else{
                library(package,character.only = TRUE)
            }
            rlang::fn_env(fn) <- as.environment(getNamespace(package))
            codetools::checkUsage(fn,name=fn_name)
            devtools::unload(package =package, quiet = TRUE)
        })

      fnCheck<-  new_function(args=list(fn = fn,
                               fn_name = fn_name,
                               dev_version = dev_version,
                               package=package),
                               body=body)
    rs <-callr::r_session$new(wait=TRUE,wait_timeout = 5000)

    outs <- rs$run_with_output(fnCheck, args = list(
        fn = fn,
        fn_name = fn_name,
        dev_version = dev_version,
        package=package
    ))
    rs$close(grace = 1000)

    if(!is.null(outs$error))
        g_stop(outs$error$message)


    tmp<-print_usage(outs$stdout,package = package,fn_only = TRUE)
    if (isTRUE(tmp))
      return(TRUE)
    invisible(tmp)
    # Returns: TRUE if no issues were found, otherwise a table of
    # potential issues.
}
