
installed_packages=function(){
  unlist(lapply(.libPaths(),list.files,include.dirs = T),use.names = F)
}


#' @export
fdoc=function(description,returns){
  assert_string(description)
  assert_string(returns)
  return(list(description,returns))
}
get_fdoc=function(func){
lines <- call_args(fn_body(func))
fdt = sapply(lines, function(x) is_call(x, "fdoc"))
if (all(fdt == FALSE))
  g_stop("function requires an fdoc(desc,returns) call")
dfile <- eval(lines[fdt][[1]])
description  <- dfile[[1]]
returns<- dfile[[2]]
desc_removed=lines[!fdt]
tmp<-new_function(args=fn_fmls(func),expr({!!!desc_removed}))
funcout<-eval(parse_expr(deparse(tmp) %sep%"\n"))
return(list(description=description,returns=returns,func=funcout))
}
#' @export
current_pkg=function(){

  if("DESCRIPTION"%nin%list.files(getwd()))stop("Current working dir is not a package. Please specific a package name")
  if(desc::desc_get('Type')!='Package')stop("Current working dir is not a package. Please specific a package name")
  desc::desc_get('Package')

}
is_fn_in_R_file=function(fn_name,file){
  #Test if a function is created within an R script
  source(file,local=T)
  env_names(current_env())
  fn_name%in%env_names(current_env())
  #Returns [Logical]
}
is_dir_RPackage=function(x=getwd()){
  if("DESCRIPTION"%nin%list.files(x))
    return(FALSE)
  if(desc::desc_get('Type',file=glue('{x}/DESCRIPTION')))
    return(FALSE)
  return(TRUE)
}
folder_names_in_dir=function(dir='~/'){
  list.dirs(dir,recursive = FALSE)  %>%
    str_split("//") %>% sapply(last)
}
local_RPackages=function(root_dir="~/"){
  fld_names<-folder_names_in_dir(root_dir)
  fld_names[sapply(glue('{root_dir}{fld_names}'),is_dir_RPackage)]
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
shiny_module_template<-function(name,args="",package=current_pkg()){
cglue('if (interactive()) {
  library(&&package&&)
bs_global_theme()

ui <- fluidPage(
    bs_dependencies(theme = bs_global_get()),
    titlePanel("&&name&& module example"),
    &&name&&_ui("mod_id")
     )

server <- function(input, output, session) {

  out<-&&name&&_server(&&args&&)

  observe({
  print(out())
  })
}
shinyApp(ui, server)
}')
}

