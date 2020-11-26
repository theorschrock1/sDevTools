
checkOutput2Table=function(x){
  out= str_split(x,"\r\n")[[1]]
  message=str_extract(out,any_inside(":","\\(|$"))
  func=str_extract(out,any_inside("^",":"))
  var<-str_extract(out,any_inside("'","'"))
  filp<-str_extract_all(out,any_inside("\\(","\\)"))
  filp= lapply(filp,function(x){
    if(len0(x))return(NA)
    x
  }) %>% unlist()
  dtmp=lapply(filp,function(x)last(str_split(x,"/")[[1]])) %>% unlist() %>% data.table()
  names(dtmp)<-"file"
  #dtmp[,c('file','line'):=tstrsplit(x,split=":")]
  dtmp[,c('message','func','var'):=list(message,func,var)]
  dtmp[,type:=NA_character_]
  dtmp[grepl('function definition',message),type:="function"]
  dtmp[grepl('global variable',message),type:="missing var"]
  dtmp[grepl('local variable',message),type:="unused var"]
  dtmp[grepl('Error while checking',message),type:="error"]
  dtmp[grepl('arguments',message),type:="arguments"]
  setcolorder(dtmp,c('file','func','var',"type",'message'))
  dtmp[]
}
