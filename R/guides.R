#' Show list of availible how to guide.

#' @name guides
#' @return \code{guides}: [Character]
#' @examples

#'  guides()
#' @export
guides <- function() {
    # Show list of availible how to guide
    list.files(paste0(system.file(package = "sDevTools"), "/guides/"))
    # Returns: [Character]
}
