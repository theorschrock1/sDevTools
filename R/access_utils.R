#' @export
get_pass=function(x){

  id=fread(get_file_id(readInp()))[x1==x]$x2
  if(len0(id))g_stop("Site '{x}' doesnt exist")
  write_clip(as_glue(get_site_id(id),allow_non_interactive = TRUE))
  return(invisible(NULL))
}
#' @export
get_sites=function(){
  fread(get_file_id(readInp()))$x1
}
#' @export
new_site=function(x){
  fp= get_file_id(readInp())
  tmp <-fread(fp)
  if(x%in%tmp$x1)g_stop("Site {x} Exists")
  newid<- sample(seq(1,100000,by=1)%NIN%tmp$x2,1)

  fwrite(rbindlist(list(tmp,data.table(x1=x,x2=newid))),fp)
  g_print("Site '{x}' added")
}
get_file_id<-function(n){
  set.seed(as.integer(n))
  paste0(create_unique_id(7),'.txt')
}
get_site_id<-function(n){
  set.seed(as.integer(n))
  create_unique_id(25)
}
readInp <- function(){

  set.seed(Sys.time())
  tmp<-sample(1:9,size=4,replace = T)%sep%""
  print(tmp)
  pw <- readline(prompt="Enter Code:")

  if(pw!=tmp)g_stop("incorrect!")
  return(as.integer(askForPassword()))
}


