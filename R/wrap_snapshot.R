#Wrap unassign code lines with 'expect_snapshot'

#' Any line without an assignment will be wrapped in \code{expect_snapshot()}.

#' @name wrap_spanshot
#' @param lines \code{[exprs]} the expressions to wrap.  any line without an assignment  that should be ignore should be wrapped in  \code{ignore()}
#' @return \code{[exprs]}

#' @examples
#'  lines=call_args(expr({di=DT(diamonds)
#'  self<-dynDT(di)
#'  ignore(di[,date:=Sys.Date()])
#'  ignore(di[,`Today's Date`:=Sys.Date()])
#'  self<-dynDT(di)
#'  self$new_variable(name='price',
#'  J="sum(price)",
#'  I=NULL,
#'  by=NULL,
#'  include_LOD=NULL,
#'  exclude_LOD=NULL,
#'  from_source=F,
#'  replace_old=T)
#'  class(self$new_variable(name='price',
#'  J="sum(price)",
#'  I=NULL,
#'  by=NULL,
#'  include_LOD=NULL,
#'  exclude_LOD=NULL,
#'  from_source=F,
#'  replace_old=T))}))
#'  wrap_spanshot(lines)

#'  #' @export
wrap_snapshot=function(lines){
assert_exprs(lines)
is_find=!sapply(lines,function(x){is_call(x,c('<-','=','ignore'))})
is_which=which(is_find)
find <- lines[is_find]
if (len0(find)) {
  g_stop("no lines without assignments")
}
replacement <- lapply(find, function(x) expr(expect_snapshot(!!x, cran = TRUE)))
is_find_ignore= sapply(lines,function(x){is_call(x,c('ignore'))})
is_which_ignore=which(is_find_ignore)

find_ignore <- lines[is_find_ignore]
if (nlen0(find_ignore )) {
  replacement <-c( replacement,lapply(find_ignore,function(x)x[[2]]))
  find=c(find,  find_ignore )
}

lines[c(is_which,is_which_ignore)]<-  replacement
lines
}
