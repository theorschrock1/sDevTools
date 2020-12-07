#' Get names of local R packages.

#' @name local_packages
#' @param root_dir  \code{[character]}  Defaults to \code{'~/'}
#' @return \code{local_packages}: \code{[character]}
#' @export
local_packages <- function(root_dir = "~/") {
    # Get names of local R packages
    if (!dir.exists(root_dir)) 
        g_stop("directory '{root_dir}' does not exist")
    fld_names <- folder_names_in_dir(root_dir)
    fld_names[sapply(glue("{root_dir}{fld_names}"), is_dir_RPackage)]
    # Returns: \code{[character]}
}
