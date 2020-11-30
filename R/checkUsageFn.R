#' Check the usage of fn internals in an isolated package environment.
#'
#'

#' @name checkUsageFn
#' @param fn  [function]
#' @param package  [choice]  NULL is ok.  Defaults to NULL
#' @return \code{checkUsageFn}: TRUE if no issues were found, otherwise a table of potential issues.
#' @examples

#'  fn <- function(x) {

#'  f(s, x)

#'  }

#'  checkUsageFn(fn, 'sDevTools')

#' @export
checkUsageFn <- function(fn,fn_name=NULL, package = NULL) {
    # Check the usage of fn internals in an isolated package
    # environment.
    assert_function(fn)
    assert_choice(package, installed_packages(), null.ok = TRUE)

    if (is.null(package))
        package = sUtils::last(stringr::str_split(getwd(), "/")[[1]])
    rlang::fn_env(fn) <- as.environment(getNamespace(package))

    rs <-callr::r_session$new(wait=TRUE,wait_timeout = 5000)
    outs <- rs$run_with_output(codetools::checkUsage, args = list(fun = fn,
        name = fn_name), package = "codetools")
    rs$close(grace = 1000)
    if (outs$stdout == "")
        return(TRUE)

    tmp=data.table(m=str_split(outs$stdout,"\r\n")[[1]])
    tmp=tmp[,.N,by=m]
    pnt=glue_data(tmp,'N({N}) {m}')

    print(pnt%sep%'\n')
    class(pnt)<-c("usage_warning",class(pnt))
    invisible(pnt)
    # Returns: TRUE if no issues were found, otherwise a table of
    # potential issues.
}
