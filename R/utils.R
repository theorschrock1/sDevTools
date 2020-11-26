
installed_packages=function(){
  unlist(lapply(.libPaths(),list.files,include.dirs = T),use.names = F)
}


#' @export
fdoc=function(description,returns){
  assert_string(description)
  assert_string(returns)
  return(list(description,returns))
}



#' @export
current_pkg=function(){

  if(!c("DESCRIPTION", "NAMESPACE","R")%all_in%list.files(getwd()))stop("Current working dir is not a package. Please specific a package name")
  last(str_split(getwd(),"/")[[1]])
}
is_fn_in_R_file=function(fn_name,file){
  #Test if a function is created within an R script
  source(file,local=T)
  env_names(current_env())
  fn_name%in%env_names(current_env())
  #Returns [Logical]
}
is_dir_RPackage=function(x){
  c("DESCRIPTION", "NAMESPACE","R")%all_in%list.files(x)
}
folder_names_in_dir=function(dir='~/'){
  list.dirs(dir,recursive = FALSE)  %>%
    str_split("//") %>% sapply(last)
}
local_RPackages=function(root_dir="~/"){
  fld_names<-folder_names_in_dir(root_dir)
  fld_names[sapply(glue('{root_dir}{fld_names}'),is_dir_RPackage)]
}

#' @export
open_fn_source=function(fn){
  fn_name=enexpr(fn) %>% deparse()
  Rpack<-environment(fn)$.packageName%IN%local_RPackages()
  if(l(Rpack)==0)
    stop("Package name not found locally")

  fil<- list.files(glue('~/{Rpack}/R/'))
  src=fil[str_remove(fil,'\\.R$')%in%fn_name]
  if(length(src)==0){
    files<-glue('~/{Rpack}/R/{fil}')
    src=files[sapply(files,is_fn_in_R_file,fn_name=fn_name)]
  }
  if(l(src)==0)stop('"{fn_name}" not found in package:{Rpack}')
  file.edit(src)
}

readInput <- function()
{
  n <- readline(prompt="Potential Usage issues. Enter 1 to continue: ")
  if(isTRUE(n!=1))g_stop("documentation aborted")
  return(as.integer(n))
}


list_to_string=function(x){

  str_trim(deparse(expr(list(!!!x)))) %>% glue_collapse()
}
c_to_string=function(x){

  str_trim(deparse(expr(c(!!!as.list(x))))) %>% glue_collapse()
}
fn_template<-function(name){

  assert_string(name)
  cglue('&&name&&<-\nfunction(&&&&args&&&&){
  fdoc({desc},{return})
  &&&&asserts&&&&

}')
}

shiny_input_template<-function(name){

  assert_string(name)
  cglue('&&name&&<-\nfunction(inputId=){

  fdoc({desc},"[html]")
   assert_string(inputId)
 &&name&&Tag<-div(id=inputId,
 ...
 )
 attachDependencies(&&name&&Tag,html_dependency_&&name&&() )
}')
}
fn_example_template<-function(name,args=""){

  glue('{name}({args})')
}
