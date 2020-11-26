#' Time the inner code of a function call.
#'
#'

#' @name fn_time
#' @param call  [call]
#' @param repeat_call  [integerish]  Must have an exact length of 1.  Defaults to 1
#' @return \code{fn_time}: [data.table]
#' @examples

#'  fn = function() {

#'  for (x in 1:5) {

#'  Sys.sleep(1)

#'  }

#'  x = 1:4000

#'  return(lapply(1:100000L, function(i) length(x)))

#'  }

#'  timetable <- fn_time(fn())

#'  timetable

#' @export
fn_time <- function(call, repeat_call = 1) {
  # Time the inner code of a function call.
  call <- enexpr(call)
  assert_call(call)
  assert_integerish(repeat_call, len = 1)
  fn = eval(call[[1]])
  body <- fn_body(fn)
  bodylines = call_args(body)
  lastExpr = bodylines[[l(bodylines)]]
  if (is_return(lastExpr)) {
    bodylines[[l(bodylines)]] <- expr(out <- !!lastExpr[[2]])
  }

  lastExpr = bodylines[[l(bodylines)]]
  if (is_call(lastExpr) & !is_assignment(lastExpr)) {
    bodylines[[l(bodylines)]] <- expr(out <- !!lastExpr[[2]])
  }

  body = expr({
    !!!bodylines
  })

  body = wrap_tic(body)
  bodylines = call_args(body)
  bodylines = c(bodylines, expr(out))
  body = expr({
    !!!bodylines
  })

  body <- expr_eval(expr_find_replace(expr(!!call[[1]]), expr(tmp_fn),
                                      in_expr = body))

  tmp_fn <- new_function(fn_fmls(fn), body)
  library(tictoc)
  tic.clearlog()
  for (i in 1:repeat_call) {
    tic("Total Time")
    expr_eval(tmp_fn(!!!call_args(call)))
    toc(log = TRUE, quiet = TRUE)
  }

  iter <- tic.log(format = FALSE) %>% rbindlist()
  iter[, `:=`(elapsed, toc - tic)]
  DTnull(iter, c("tic", "toc"))
  iter <- iter[, .(elapsed = mean(elapsed), called = .N), by = .(msg)]
  tt = iter[msg == "Total Time"]$elapsed
  iter = iter[msg != "Total Time"]
  iter[, `:=`(`time%`, elapsed/tt)]
  setcolorder(iter, c("elapsed", "time%", "msg"))
  iter <- iter[order(-elapsed)]
  p_out = c(glue_data(iter[elapsed > 0], "{round(elapsed,3)} sec ({round(`time%`*100,3)}%) : {ifelse(str_count(msg)>100,paste0(str_sub(msg,start=1,end=100),'...'),msg)}"),
            glue("Avg Total Run Time:\n{ round(tt,4)} sec")) %sep%
    "\n"
  print(p_out)
  invisible(iter)
  # Returns: [data.table]
}
#' @export
wrap_tic=function(x){
  if(expr_has_call_name(x,"{")){
    br=expr_extract_call(x,"{")
    replace<-lapply(br,wrap_tic)
    for(i in 1:l(br)){
      x=expr_find_replace(br[[i]],replacement = replace[[i]],in_expr =x)
    }
  }
  lines = deparse(x) %>% fix_lines()
  lines = str_trim(lines[2:(l(lines) - 1)])

  tmp=str_replace_all(str_trim(lines),"\'","\"")
  tmp=str_remove_all(tmp,"tic\\(.*\\)\n")
  tmp=str_remove_all(tmp,"toc\\(.*\\)")
  body = glue("tic('{tmp}')\n{lines}\ntoc(quiet=TRUE,log=TRUE)") %sep%"\n"
  body <- glue("{\n&&body&&\n}", .open = "&&", .close = "&&") %>% parse_expr()
  return(body)
}
