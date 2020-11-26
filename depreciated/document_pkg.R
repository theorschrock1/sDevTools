#' Build package documentation.

#' @name document_pkg
#' @return \code{document_pkg}: NULL
#' @export
document_pkg <- function(package=current_pkg()) {
    # Build package documentation
  library(package,character.only = TRUE)
  detach(
    glue("package:{package}"),
    unload = TRUE,
    force = TRUE,
    character.only = TRUE
  )
  devtools::document(roclets = c("rd", "collate", "namespace"))

  .rs.restartR()
  library(sDevTools)
  library(package,character.only = T)

    # Returns: NULL
}
