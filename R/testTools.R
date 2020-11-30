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
