#' Assert that the current dir is an sDevTools Project.
#'
#' 

#' @name assert_sdevtools_proj
#' @param dir  \code{[directory]}  Defaults to \code{getwd()}
#' @return \code{assert_sdevtools_proj}: Throw an error if FALSE
#' @export
assert_sdevtools_proj <- function(dir = getwd()) {
    # Assert that the current dir is an sDevTools Project.
    assert_directory(dir)
    if (!file.exists(".sDevToolsProj")) 
        g_stop("sDevTools has not been initialized in this directory.  Please run sDevTools_initialize().")
    # Returns: Throw an error if FALSE
}
