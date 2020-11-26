#' Restart and reload environment.

#' @name restartAndReload
#' @return \code{restartAndReload}: NULL
#' @export
restartAndReload <- function() {
    # Restart and reload environment
    packs = rev(loaded_packages()$package)
    .rs.restartR()
    load_packages(packs)
    # Returns: NULL
}
