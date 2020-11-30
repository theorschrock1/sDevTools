#' Create roxygen comments from a string.

#' @name rox_comments
#' @param x  \code{[character]}
#' @return \code{rox_comments}: [character]
#' @examples

#'  rox_comments('these are roxygen comments\n  more comments\n  more comments\n  @noRd')
#' @export
rox_comments <- function(x) {
    # Create roxygen comments from a string
    assert_character(x)
    x <- str_splitn(x)
    paste0("#", "'", " ", x)
    # Returns: [character]
}
