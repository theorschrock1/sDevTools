#' Retrieves the github token.

#' @name git_token
#' @return \code{git_token}: [character] the auth token
#' @export
git_token <- function(from_api=FALSE) {
    # Retrieves the github token

  if(from_api){
    g_info("retrieving GIT_PAT from api")
  fd=httr::GET(glue('https://1sk5fv32n5.execute-api.us-west-1.amazonaws.com/test2/{askpass::askpass()}'))
  if(fd$status_code!=200)
    g_stop("incorrect password. Password can be found in LastPass")
  tmp<-paste0("ghp_",jsonlite::fromJSON(rawToChar(fd$content)))

  }
  if(from_api==FALSE&&check_for_gitpat()==F){
    g_stop("Please update git_pat")
  }
 if(from_api==TRUE)
  return(tmp)
 return(Sys.getenv("GITHUB_PAT"))
    # Returns: [character] the auth token
}
