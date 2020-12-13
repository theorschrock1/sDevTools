#DevScript ------
devSetup=function(package=current_pkg()){
  text=c('###Dev Setup -----',
         '## INSTALL: CTRL + SHIFT + B',
         'sDevTools::clearEnv() ## CTRL + SHIFT + R',
         'library(sDevTools)',
         'sDevTools::loadUtils()')
  if(package=="sDevTools")
    text<-text%NIN%'library(sDevTools)'
  cglue(text%sep%"\n")
}
devCheck=function(package=current_pkg()){
  text=c('#Check Usage -----',
         'checks=checkPackageUsage()',
         'runTests(package="&&package&&")',
         '#Dismiss Usage Warnings -----',
         '#  suppressUsageWarnings(checks)')
  if(len0(list.files('tests/testthat'))){
    text<-text%NIN%'runTests("&&package&&")'
  }
  cglue(text%sep%"\n")
}
devDev=function(fn_name,type='standard',package=current_pkg()){
  assert_string(fn_name,null.ok = TRUE)
  assert_choice(type,choices=c("standard","shiny"))
  fn_tmp='new_fn((),#args\n desc=  ,#Function description\n return=  #Function returns\n )'
  document= ''
  if(nnull(fn_name)){
    if(type=='standard'){
      fn_tmp=fn_template(fn_name)
      example_tmp=fn_example_template(fn_name)
    }
    if(type=="shiny"){
      fn_tmp=shiny_input_template(fn_name)
      example_tmp=shiny_example_template(fn_name)
    }
    document=cglue('#document ----\nfn_document(&&fn_name&&,{
    &&example_tmp&&
  })')
  }
  cglue('#Dev -----
&&fn_tmp&&
&&document&&')
}
devTest=function(fn_name,examples=NULL){
  assert_string(fn_name)
  examples<-examples%or% get_fn_examples(fn_name)
  assert_call(examples,"{")
  tests=exprs_deparse(list(  examples))[[1]]
  tests=glue("build_test('{fn_name}',
              init=NULL,
              test_code={tests},
              overwrite=TRUE)")
  cglue('#test ----
  ## INSTALL: CTRL + SHIFT + B
  &&tests&&

  # Refresh Dev =====
  #refresh_dev()')
}
devDoc=function(fn_name=NULL,type='standard',package=current_pkg(),test_only=FALSE){
  if(test_only){
    if(is.null(fn_name))g_stop("Missing funciton name")
    out=c(devCheck(package),
          devSetup(package),
          devTest(fn_name))%sep%"\n"

  }else{
    out= c(devCheck(package),
           devSetup(package),
           devDev(fn_name,type,package))%sep%"\n"
  }

  dev_id=getDocumentId('DEV')
  if(len0(dev_id))g_stop("DEV id not found")
  setDocumentContents(out,id=dev_id)
  lines<-unlist(str_split(out,"\n"))
  rowid=which(grepl('#Dev -----',lines))+1
  navto=c(rowid,8)
  if(nnull(fn_name))navto=c(rowid+1,10)
  if(type=='shiny')navto=c(rowid+1,18)
  navigateToFile(
    file = 'dev/Dev.R',
    line = navto[1],
    column =navto[2],
    moveCursor = TRUE
  )

}
