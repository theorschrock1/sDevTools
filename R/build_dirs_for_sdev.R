#' Build the directories used by sDevTools.

#' @name build_dirs_for_sdev
#' @return \code{build_dirs_for_sdev}: NULL
#' @export
build_dirs_for_sdev <- function() {
    # Build the directories used by sDevTools
    dir.create("inst")
    dir.create("inst/assets")
    dir.create("inst/templates")
    dir.create("dev")
    dir.create("depreciated")
    dir.create("depreciated/oldDevs")
    # Returns: NULL
}
