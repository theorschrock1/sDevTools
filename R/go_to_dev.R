#' Go to Dev file.

#' @name go_to_dev
#' @return \code{go_to_dev}: [NULL]
#' @examples

#'  go_to_dev()
#' @export
go_to_dev <- function() {
    # Go to Dev file
  # if(!file.exists("dev/DEV.R")){
  #   refresh_dev()
  #   return(invisible(NULL))
  # }
    file.edit("dev/DEV.R")
    # Returns: [NULL]
}
