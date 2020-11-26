#' @export
test_summary=function(x)UseMethod('test_summary')
#' @export
test_summary.default=function(x){
  list(N=length(x),class=class(x),values=unique(x))
}
#' @export
test_summary.factor=function(x){
  list(N=length(x),class=class(x),values=as.character(unique(x)),levels=levels(x),as_numeric=as.numeric(unique(x)),anyMissing=anyNA(x),ordered=is.ordered(x))
}
#' @export
test_summary.data.table=function(x){
  att=attributes(x)
  att$.internal.selfref=NULL
  if(nnull( att$casted_factors)){
    att$casted_factors=lapply(att$casted_factors,test_summary)
  }
  list(rows=nrow(x),cols=ncol(x),attributes=att)
}
#' @export
test_summary.list=function(x){
  att=attributes(x)

  list(length=length(x),attributes=att)
}
#' @export
test_summary.numeric=function(x){
  list(sum=sum(x,na.rm = T),min=min(x,na.rm = T),max=max(x,na.rm = T),avg=mean(x,na.rm = T),N=length(na.omit(x)),class=class(x),anyMissing=anyNA(x))
}
#' @export
test_summary.Date=function(x){
  list(min=min(x,na.rm = T),max=max(x,na.rm = T),avg=mean(x,na.rm = T),N=length(na.omit(x)),class=class(x),anyMissing=anyNA(x))
}
#' @export
test_summary.POSIXct=function(x){
  list(min=min(x,na.rm = T),max=max(x,na.rm = T),avg=mean(x,na.rm = T),N=length(na.omit(x)),class=class(x),anyMissing=anyNA(x))
}
#' @export
test_summary.integer=function(x){
  list(sum=sum(x,na.rm = T),min=min(x,na.rm = T),max=max(x,na.rm = T),avg=mean(x,na.rm = T),N=length(na.omit(x)),class=class(x),anyMissing=anyNA(x))
}
#' @export
test_summary.call=function(x){
  list(exprTools::exprs_deparse(list(x))[[1]])
}
#' @export
test_summary.units=function(x){
  list(attr(x,"units"),sum=sum(x,na.rm = T),min=min(x,na.rm = T),max=max(x,na.rm = T),avg=mean(x,na.rm = T),N=length(na.omit(x)),class=class(x),anyMissing=anyNA(x))
}

#' @export
build_test_output=function(output,code_expr)UseMethod("build_test_output")
#' @export
build_test_output.data.table=function(output,code_expr){
  setnames(output,exprTools::make_names_unique(names(output)))

  mainSummary<-test_summary(output)
  innerSummary<-lapply(output,test_summary)
  n=names(output)
  inner=c(expr(`<-`(output,expect_data_table(!!code_expr))),
          exprTools::expr_glue('expect_equal(test_summary(output), {list(mainSummary)})'),
          exprTools::expr_glue('expect_equal(test_summary(output[["{n}"]]), {innerSummary})'))
  return(inner)
}
#' @export
build_test_output.default=function(output,code_expr){
  inner=c(expr(`<-`(output,!!code_expr)),
           expr(expect_equal(test_summary(output), !!test_summary(output))))
  return(inner)
}
#' @export
build_test_output.numeric=function(output,code_expr){

  mainSummary<-test_summary(output)

  inner=c(expr(`<-`(output,expect_numeric(!!code_expr))),
          exprTools::expr_glue('expect_equal(test_summary(output), {list(mainSummary)})'))
  return(inner)
}
#' @export
build_test_output.integer=function(output,code_expr){

  mainSummary<-test_summary(output)

  inner=c(expr(`<-`(output,expect_integer(!!code_expr))),
          exprTools::expr_glue('expect_equal(test_summary(output), {list(mainSummary)})'))
  return(inner)
}
#' @export
build_test_output.factor=function(output,code_expr){

  mainSummary<-test_summary(output)

  inner=c(expr(`<-`(output,expect_factor(!!code_expr))),
          exprTools::expr_glue('expect_equal(test_summary(output), {list(mainSummary)})'))
  return(inner)
}
#' @export
build_test_output.ordered=function(output,code_expr){

  mainSummary<-test_summary(output)

  inner=c(expr(`<-`(output,expect_ordered(!!code_expr))),
          exprTools::expr_glue('expect_equal(test_summary(output), {list(mainSummary)})'))
  return(inner)
}
#' @export
build_test_output.Date=function(output,code_expr){
  dup=anyDuplicated(output)>0
  test= expr(expect_date(!!code_expr,lower = !!min(output), upper =!!max(output), any.missing =  !!anyNA(output),len = !!length(output),unique= !!dup))

  return(list(test))
}
#' @export
build_test_output.POSIXct=function(output,code_expr){
  dup=anyDuplicated(output)>0
  test= expr(expect_posixct(!!code_expr,lower = !!min(output), upper =!!max(output), any.missing =  !!anyNA(output),len = !!length(output),unique= !!dup))

  return(list(test))
}
#' @export
build_test_output.units=function(output,code_expr){
  test= expr(expect_equal(test_summary(output), !!test_summary(output)))
  return(list(test))
}
#' @export
build_test_output.list=function(output,code_expr){

  mainSummary<-test_summary(output)
  innerSummary<-lapply(output,test_summary)
  if(is_named(output)){
    n=names(output)
    inner=c(expr(`<-`(output,expect_list(!!code_expr))),
            exprTools::expr_glue('expect_equal(test_summary(output), {list(mainSummary)})'),
            exprTools::expr_glue('expect_equal(test_summary(output[["{n}"]]), {innerSummary})'))
    return(inner)
  }

  n=1:l(output)
  inner=c(expr(`<-`(output,expect_list(!!code_expr))),
          exprTools::expr_glue('expect_equal(test_summary(output), {list(mainSummary)})'),
          exprTools::expr_glue('expect_equal(test_summary(output[[{n}]]), {innerSummary})'))
  return(inner)
}
#' @export
build_test_output.call=function(output,code_expr){


  inner=c(expr(`<-`(output,!!code_expr)),
          expr(expect_true(exprTools::is_expr_equal(output,expr(!!output)))))
  return(inner)
}
#' @export
build_test_output.DataTable=function(output,code_expr){
  output<-output$data
  tmp=expr(expr$data)
  tmp[[2]]<-code_expr
  build_test_output(output,tmp)
}
#' @export
bracket_exprs=function(x,assign_to=NULL){
  exprTools::assert_exprs(x)
  assert_character(assign_to,len=1,null.ok = TRUE)
  if(is.null(assign_to))return(expr({!!!x}))
  expr(`<-`(!!sym(assign_to),{!!!x}))
}
