#' Times each line in run in a function.

#' @name expr_fn_timelines
#' @param call  [call] a function call
#' @param rep  [integerish]  How many time should the call be tested? Must have an exact length of 1.  Defaults to 1
#' @return  invisible([data.table]) showing the average elasped times of each line

#' @examples

#'  library(data.table)

#'  fn = function() {

#'  ChickWeight = as.data.table(ChickWeight)

#'  setnames(ChickWeight, tolower(names(ChickWeight)))

#'  DT <- melt(as.data.table(ChickWeight), id = 2:4)

#'  dcast(DT, time ~ variable, fun = mean)

#'  dcast(DT, diet ~ variable, fun = mean)

#'  dcast(DT, diet + chick ~ time, drop = FALSE)

#'  dcast(DT, diet + chick ~ time, drop = FALSE, fill = 0)

#'  dcast(DT, chick ~ time, fun = mean, subset = .(time <

#'  10 & chick < 20))

#'  }

#'  time_table <- expr_fn_timelines(fn())

#'  time_table

#'  expr_fn_timelines(fn(), rep = 20)

#' @export
expr_fn_timelines <- function(call, rep = 1) {
  # Times each line in run in a function
  call <- enexpr(call)
  assert_call(call)
  assert_integerish(rep, len = 1)
  fn = eval(call[[1]])
  lines = deparse(fn_body(fn)) %>% fix_lines()
  lines = lines[2:(l(lines) - 1)]
  iter = 1:l(lines)
  body = glue("tic('{str_trim(lines)}')\n{lines}\ntime[[{iter}]]<-toc(quiet=TRUE)") %sep%
    "\n"
  body <- glue("{\ntime=list()\n&&body&&\nreturn(time)\n}", .open = "&&", .close = "&&") %>%
    parse_expr()

  tmp_fn <- new_function(fn_fmls(fn), body)
  library(tictoc)
  iter = list()
  for (i in 1:rep) {
    tmp = expr_eval(tmp_fn(!!!call_args(call))) %>% rbindlist()
    tmp[, `:=`(line_num, seq_len(len(tmp)))]
    iter <- rbindlist(list(iter, tmp))
  }

  iter[, `:=`(elapsed, toc - tic)]
  DTnull(iter, c("tic", "toc"))
  iter <- iter[, .(elapsed = mean(elapsed)), by = .(line_num, msg)]

  iter[, `:=`(`time%`, elapsed/sum(elapsed))]
  setcolorder(iter, c("line_num", "elapsed", "time%", "msg"))
  iter <- iter[order(-elapsed)]
  print(glue_data(iter[elapsed > 0], "Line {line_num}: {round(elapsed,3)} sec ({round(`time%`,3)}%) : {ifelse(str_count(msg)>40,paste0(str_sub(msg,start=1,end=40),'...'),msg)}"))
  g_print("
            Avg Total Run Time:{ round(sum(iter$elapsed),4)} sec")
  invisible(iter)
  # Returns: invisible([data.table]) showing the elased times of each line
}
