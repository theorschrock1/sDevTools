#' Open a 'how to' guide.

#' @name open_guide
#' @param guide  [file_exists]
#' @return \code{open_guide}: [NULL]
#' @export
open_guide <- function(guide) {
    # Open a 'how to' guide
    g0 = guide
    guide = paste0(system.file(package = "sDevTools"), "/guides/", 
        guide)
    assert_file_exists(guide)
    file.copy(guide, tempfile(fileext = g0))
    file.edit(guide)
    # Returns: [NULL]
}
