#' Add a file to git.

#' @name add2Git
#' @param file  \code{[file]} The file to add to GIT. If NULL and also committing to GIT, a message is required.
#' @param message  \code{[string]}  The commit message. Must have an exact length of \code{1}.  Defaults to \code{NULL}
#' @param commit  \code{[logical]}  Should the added files be committed to GIT? Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param push  \code{[logical]} If committing to GIT, should changes be pushed to Github? Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param bump_version  \code{[logical]} Increase the package version number? Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{add2Git}: invisible([NULL])
#' @export
add2Git<-
    function(file=NULL,message=NULL,commit=TRUE,push=TRUE,staged_only=TRUE,bump_version=TRUE){
        #Add a file to git

        #Assertions
        if(nnull(file))
            assert_file(file)
        assert_string(message,null.ok=TRUE)
        assert_logical(commit, len = 1)
        assert_logical(push, len = 1)
        assert_logical(bump_version, len = 1)
        assert_git(getwd())
        #TO DO

        if(nnull(file)){
        git2r::add(path=file)
        fname=last(str_split(file,"/")[[1]])
        message=message%or%glue("added {fname}")

        }else{
            git2r::add()
        }

        if(commit)
            if(is.null(message))
                g_stop("If file is NULL, a message is required")
            commitPush2Github(message, push_github =push,bump_version=bump_version)
        return(invisible(NULL))
        #Returns invisible(NULL)
    }
