#' Check if system is connected to the internet

#' @name is_internet_connected()
#' @return \code{[logical(1)]}
#' @examples
#'  is_internet_connected()
#' @export
is_internet_connected <- function() {
  # Check if system is connected to the internet

  tryCatch(
    is.character(curl::nslookup("www.r-project.org")),
    error = function(e)
      FALSE)
  # Returns: [Logical(1)]
}
