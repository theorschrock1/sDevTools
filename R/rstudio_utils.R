
##rstudio api----
getDocumentIds=function(){
  er<-list.dirs('.Rproj.user',recursive = FALSE)
  ppath=er[!grepl('shared',list.dirs('.Rproj.user',recursive = FALSE))]
  er<-list.dirs(paste0(ppath,"/sources"),recursive = FALSE)
  cpath<-er[!grepl('per|prop',er)]
  fd<-list.files(cpath)
  fds<-paste0(cpath,"/",fd[!grepl('contents|lock_file',fd)])

  lapply(fds,function(x){
    x=fromJSON(x)
    data.table(path=x$path%or%"none",id=x$id,last_update=x$last_content_update)
  }) %>% rbindlist()
}
tilda_path=function(){

  paste0(dirname("~"),"/",basename('~'))
}

getDocumentId=function(name,dir='dev'){
  projdir<-str_remove(getwd(),paste0(tilda_path(),"/"))
  ids<-getDocumentIds()[tolower(path)%like%tolower(glue('~/{projdir}/{dir}/{name}.R'))]$id
  ids
}
getLastEditedDocumentId=function(){
  ds<-getDocumentIds()
  ds[which.max(ds$last_update)]$id
}
getLastEditedDocument=function(){
  ds<-getDocumentIds()
  out=ds[which.max(ds$last_update)]
  list(path=out$path,id=out$id)
}
getDocumentContext=function(name,dir='dev',id=NULL){
  if(is.null(id))
    id=getDocumentId(name,dir)
  er<-list.dirs('.Rproj.user',recursive = FALSE)
  ppath=er[!grepl('shared',list.dirs('.Rproj.user',recursive = FALSE))]
  er<-list.dirs(paste0(ppath,"/sources"),recursive = FALSE)
  cpath<-er[!grepl('per|prop',er)]
  fd<-list.files(cpath)
  fds<-paste0(cpath,"/",fd[!grepl('lock_file',fd)])

  meta<-fds%grep%ends_with(id)
  content<-fds%grep%ends_with(paste0(id,'-contents'))
  er= fromJSON(  meta)
  out=list(id=er$id,path=er$path,contents=c(readLines( content)),cursor=as.numeric(str_split(er$properties$cursorPosition,',')[[1]]))
  out

}
isEditorDev=function(){
  getLastEditedDocument()$path
  grepl("dev/DEV.R",getLastEditedDocument()$path)
}
insertAtCursor=function(text="",row.offset=0){
  assert_string(text)
  assert_int(row.offset)
  rowid<-currentCursor()$row.end+0-2
  insertText(location=document_position(rowid,1),text=text,id=getLastEditedDocumentId())
}
replaceLastLine=function(text="",insert_at_col=1,require_selection=FALSE){
  assert_string(text)
  assert_integerish(insert_at_col)
  doc_id=getLastEditedDocumentId()
  contents<-getDocumentContext(id=doc_id)$contents
  cc<-currentCursor()
  if(require_selection&&cc$text=="")g_stop("Must be run as a selection")
  out<-contents[ifelse(cc$text!="",cc$row.end,cc$row.end-1)]
  rowid<-ifelse(cc$text!="",cc$row.end,cc$row.end-1)
  while(out==""){
    rowid=rowid-1
    out<-contents[rowid]
    if(rowid<1)g_stop("Couldn't locate selection")
  }

  p=try(parse_expr(out),silent = T)
  if(is_error(p)){
    print(out)
    g_stop("Last line must be run is on a single line.")
  }
  if(insert_at_col>1)
    modifyRange(document_range(document_position(rowid,1),document_position(rowid, Inf)), text =rep(" ",insert_at_col)%sep%"", id =  doc_id)
  modifyRange(document_range(document_position(rowid,insert_at_col),document_position(rowid, Inf)), text =text, id =  doc_id)
  setCursorPosition(document_position(rowid, insert_at_col), id =doc_id)
}

#' @export
go_to_selection=function(){

    sel<- str_trim(read_clip())

  open_fn_source(sel)
}
#' @export
check_usage_selection=function(env=caller_env()){
fn<-get(str_trim(read_clip()),env=env)
checkUsageFn(fn=fn)
}
#' @export
clear_env_load_all=function(){
sDevTools::clearEnv()
sDevTools::loadUtils()
}
#' @export
toggle_roxygen_comments<-
  function(){

    #Comment/uncomment roxygen
  id=getLastEditedDocumentId()
  value<-suppressWarnings(currentCursor()$text)
    value<- str_splitn(value)
    if(all(value[value!=""]%detect%start_with("\\s*\\#'"))){
      value<-str_remove(value,"\\#'")%sep%'\n'
      selectionSet(value=value,id=id)
      return(invisible(NULL))
    }
    value[!grepl(start_with("\\s*\\#'"),value)]<-paste("#' ", value[!grepl(start_with("\\s*\\#'"),value)])
    value<-value%sep%"\n"
    selectionSet(value=value,id=id)
    return(invisible(NULL))
    #return invisible(NULL) comments/uncomments out selection
  }


