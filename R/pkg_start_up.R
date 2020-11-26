#' Generate a R Package Start-up file.

#' @name pkg_start_up
#' @param pkg_name  [string]
#' @return \code{pkg_start_up}: NULL
#' @export
pkg_start_up <- function(pkg_name) {
    # Generate a R Package Start-up file
    assert_string(pkg_name)
    file.remove("NAMESPACE")
    file.remove("R/hello.R")
    build_dirs_for_sdev()

    tmp <- readLines(paste0(system.file(package = "sDevTools"), "templates/START_UP.R")) %sep%
        "\n"
    tmp = glue(tmp)
    write(tmp, file = "START_UP.R")
    tmp <- readLines(paste0(system.file(package = "sDevTools"), "templates/DEV.R")) %sep%
        "\n"
    tmp = cglue(tmp)
    write(tmp, file = "DEV.R")
    file.edit("START_UP.R")

    # Returns: NULL
}
