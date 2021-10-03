#' Creates an Renviron file with GITHUB_PAT
#'

#' @name use_gitpat_renviron
#' @return \code{use_gitpat_renviron}: NULL
#' @export
use_gitpat_renviron <- function(git_pat=git_token()) {
    # Creates an .Renviron file with GITHUB_PAT
    assert_string(git_pat,pattern = "^ghp")
    if(file.exists(".Renviron")){
        tmp<-readLines(".Renviron")
      pat <- tmp[str_detect(tmp,"^GITHUB_PAT")]
    if(nlen0(pat)){
       tmp[pat]<-glue("GITHUB_PAT={git_pat}")
    }else{
       tmp= c(tmp[tmp!=""],glue("GITHUB_PAT={git_pat}"),"")
    }
      write(tmp,".Renviron")
      g_success("GIT_PAT updated successfully")
      return()
      }else{
    write(git_pat,
        ".Renviron")
    g_success(".Renviron created. GIT_PAT updated successfully") }
    restartAndReload()
    # Returns: NULL
}
check_for_gitpat=function(){
   out<- str_detect(Sys.getenv("GITHUB_PAT"),"ghp_")
   if(out==F)
       g_warn("git_pat missing or outdated. update git_pat with `use_gitpat_renviron()`")
   return(out)
   }


