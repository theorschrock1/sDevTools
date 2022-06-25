#' commit all changes and push to github.

#' @name commitPush2Github
#' @param message  \code{[string]} the commit message
#' @param push_github  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param bump_version  \code{[logical]} Increase the package version number? Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{commitPush2Github}: [NULL]
#' @export
commitPush2Github <- function(message, push_github = TRUE,bump_version=TRUE) {
    # commit all changes and push to github
    assert_string(message)
    assert_logical(bump_version, len = 1)
    assert_logical(push_github, len = 1)
    assert_git(getwd())
    if(bump_version&file.exists(glue('{getwd()}/DESCRIPTION'))){
    oldver<- desc::desc_get_version(file = ".")
    suppressMessages(desc::desc_bump_version("dev"))
    newvar<- desc::desc_get_version(file = ".")
    g_success("Version bumped from '{oldver}' to '{newvar}'")
    }
    error<-try(git2r::commit(message = message, all = FALSE),silent=TRUE)
    if(is_error(error)){
        if(!grepl('Nothing added to commit',error))
            stop(error)
        cli::cli_alert_info("GIT: No changes to commit")
    }else{
        g_success("Commiting '{message}' to git")
    }

    if(push_github){
        push_github=is_internet_connected()
        if(!push_github)
            cli::cli_alert_warning("Not pushing to github: internet not connected")
        }
    if (push_github & !file.exists(".Renviron")) {
        use_gitpat_renviron()
    }
    if (push_github){

        git2r::push(credentials = git2r::cred_token())
        #g_success("Pushing to github")
    }
    # Returns: [NULL]
}

