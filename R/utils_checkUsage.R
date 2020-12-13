print_usage=function(stdout,package,hide_suppressed=FALSE,fn_only=FALSE){
  if(stdout==""){
    g_success("No usage issues!")
    return(TRUE)
  }
    tmp=data.table(m=str_split(stdout,"\r\n")[[1]])

  #print(pnt%sep%'\n')
if(!fn_only)
  tmp<-tmp[str_detect(tmp$m,"R\\/.*?\\.R")]
tmp[,fp:=str_trim(str_extract(tmp$m,"R\\/.*?\\.R"))]
if(!fn_only)
  tmp[,line:=str_trim(str_extract(tmp$m,any_inside("\\.R:","\\)$")))]
if(fn_only)
  tmp[,line:=str_trim(str_extract(tmp$m,any_inside("\\(:","\\)$")))]
tmp[,var:=str_extract(tmp$m,any_inside("'","'"))]
tmp[,fn:=str_trim(str_extract(tmp$m,any_inside("^",":")))]

tmp[,message:=ifelse(m%detect%'global variable',"missing variable definition",ifelse(m%detect%'global function','missing function definition',ifelse(m%detect%'parameter'&m%detect%'changed by assignment','parameter changed by assignment',ifelse(m%detect%'parameter'& m%detect%'may not be used','parameter may not be used',ifelse(m%detect%'local variable'&m%detect%'may not be used','local variable may not be used',ifelse(m%detect%'used as function with no','local variable used as function with no definition',ifelse(m%detect%'multiple local function definitions','multiple local function definitions',str_trim(str_extract(m,any_inside(":","\\("))))))))))]
tmp[message%like%'function',var:=paste0(var,'()')]
if(!fn_only&hide_suppressed&file.exists(glue('~/RUsageTests/{package}/suppress.csv'))){
  setkey(tmp,var,message)
  suppress=fread(glue('~/RUsageTests/{package}/suppress.csv'))
  setkey(suppress,var,message)
  tmp<-tmp[!suppress]
}
tmp<-tmp[m!=""]
if(nrow(tmp)==0){
  g_success("No usage issues!")
  return(TRUE)
}
tmp[is.na(fp),fp:=""]
tmp[is.na(line),line:=""]
tmp[is.na(fn),fn:="<anonymous>"]
xs=split(tmp,by='fn')
lapply(xs,.print_usage)
class(tmp)<-c("usage_warning",class(tmp))
tmp
}
.print_usage=function(x){
  print(cli::rule(left=p_purple(unique(x$fn)),right=p_purple(unique(x$fp))))
  out<-glue_data(x,'  {1:l(var)}) {var} {style_message(message)} {line}')%sep%'\n'
  print(out)
  return(invisible(NULL))
}
p_info<-function(x){
 x= cli::make_ansi_style('#88fcf6')(x)
  }
p_danger<-function(x){
  cli::make_ansi_style('#f0412e')(x)
}
p_warn<-function(x){
cli::make_ansi_style("#ffaa00")(x)
}
p_purple<-function(x){
cli::make_ansi_style('#fc88fa')(x)
}
p_green<-function(x){
cli::make_ansi_style('#9dfca6')(x)
}
p_gray<-function(x){
cli::make_ansi_style('#bfbfbf')(x)
}
style_message=function(x){

  fifelse(x=='parameter changed by assignment',p_green(x),
  fifelse(x=='missing variable definition',p_warn(x),
  fifelse(x=='missing function definition',p_danger(x),
  fifelse(x=='local variable may not be used',p_info(x),
  fifelse(x=='multiple local function definitions',p_warn(x),
  fifelse(x=='parameter may not be used',p_green(x),
  fifelse(x=='local variable used as function with no definition',p_warn(x),p_green(x))))))))
}
