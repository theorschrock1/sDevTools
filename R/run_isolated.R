#' Run R code in an isolated R session.

#' @name run_isolated
#' @param test  [call]
#' @param package  [choice]  NULL is ok.  Defaults to current_pkg()
#' @return \code{run_isolated}: list of results
#' @examples

#'  x <- 1
#'  run_isolated({
#'  x + 1
#'  })
#'  run_isolated({
#'  x <- 1
#'  x + 1
#'  })
#' @export
run_isolated <- function(test, package = current_pkg()) {
  # Test code in an isolated R session
  test <- enexpr(test)
  assert_call(test, "{")
  assert_choice(package, installed_packages(), null.ok = TRUE)
  toRun <- c(call_args(test), expr(return(TRUE)))
  body = expr({
    !!!toRun
  })
  fn = new_function(args = NULL, body = body)
  rs <- callr::r_session$new( wait = TRUE)
  outs <- rs$run_with_output(fn, package = package)
  rs$close(grace = 1000)

  outs
  # Returns: List of results
}
