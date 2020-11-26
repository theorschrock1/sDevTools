#' Go to an R file in the R dir.

#' @name go_to
#' @param R_file  [file_exists]
#' @return \code{go_to}: NULL
#' @export
go_to <- function(R_file) {
    # Go to an R file in the R dir
    if (!str_detect(R_file, ends_with("\\.[rR]"))) 
        R_file <- paste0(R_file, ".R")
    R_file = paste0("R/", R_file)
    assert_file_exists(R_file)
    file.edit(R_file)
    # Returns: NULL
}
