#' Check the usage of all function internals in a package in an isolated environment.
#'
#'

#' @name checkPackageUsage
#' @param package  [choice]  NULL is ok.  Defaults to NULL
#' @return \code{checkPackageFns}: TRUE if no issues were found, otherwise a table of potential issues.
#' @export
checkPackageUsage <- function(package = NULL) {
    # Check the usage of all function internals in a package in an
    # isolated environment.
    assert_choice(package, installed_packages(), null.ok = TRUE)
    if (is.null(package))
        package = sUtils::last(stringr::str_split(getwd(), "/")[[1]])
    body = expr({
        library(!!package)
        codetools::checkUsagePackage(!!package)
    })
    fn = rlang::new_function(args = NULL, body = body)
    rs <- callr::r_session$new( wait = TRUE)
    outs <- rs$run_with_output(fn)
    rs$close(grace = 1000)
    if (outs$stdout == "")
        return(TRUE)

   tmp=data.table(m=str_split(outs$stdout,"\r\n")[[1]])
   tmp=tmp[,.N,by=m]
   pnt=glue_data(tmp,'N({N}) {m}')
   if(file.exists(glue('~/RUsageTests/{package}/suppress.rds'))){
       suppress=readRDS(glue('~/RUsageTests/{package}/suppress.rds'))
       pnt=pnt%NIN%suppress
       if(len0(pnt))
           return(TRUE)
       }
   print(pnt%sep%'\n')
   class(pnt)<-c("usage_warning",class(pnt))
   invisible(pnt)
    # Returns: TRUE if no issues were found, otherwise a table of
    # potential issues.
}

