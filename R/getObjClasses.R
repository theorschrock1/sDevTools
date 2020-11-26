#' Get the classes of all objects in a package.

#' @name getObjClasses
#' @param env  \code{[Environment]} an environment
#' @param classtype \code{[character]} a vector of class names
#' @return \code{getPackageObjClasses}: [named character]
#' @export
getObjClasses <- function(env = package_env(),classtype=NULL) {
    # Get the classes of all objects in a package
    assert_environment(env)
    assert_character(classtype,null.ok = TRUE)
    out<-sapply(env, class)
  if(is.null(classtype))
    return(out)
    out%IN%classtype
    # Returns: [named character]
}
