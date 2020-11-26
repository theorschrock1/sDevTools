#' Clear the global environment.

#' @name clearEnv
#' @return \code{clearEnv}: [NNULL]
#' @export
clearEnv=function(){
  rm(list=ls(globalenv()),envir =globalenv() )
}
