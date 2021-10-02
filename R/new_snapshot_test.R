#' create a new snapshot test.
#'
#' Any line without an assignment will be wrapped in \code{expect_snapshot()}.

#' @name new_snapshot_test
#' @param name  \code{[string]} the test name
#' @param code \code{[expr]} the code to test, wrapped in brackets.
#' @param overwrite  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param commit_git  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param push_github  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{new_snapshot_test}: invisible(NULL) Writes a test file to the tests/thatthat directory
#' @export
new_snapshot_test <- function(name, code, overwrite = FALSE, commit_git  = TRUE, push_github = TRUE) {
  # Build a snapshot test
  assert_string(name)
  assert_logical(commit_git, len = 1)
  assert_logical(push_github, len = 1)
  assert_logical(overwrite, len = 1)
  code <- enexpr(code)
  testpath = glue("tests/testthat/test_{name}.R")
  if (file.exists(testpath)) {
    if (overwrite == FALSE)
      g_stop("test \"{name}\" exists. Use \"overwrite=TRUE\" if this was intentional")
    snaps <- paste0("tests/testthat/_snaps/", list.files("tests/testthat/_snaps/", pattern = name))
    if (nlen0(snaps))
      invisible(lapply(snaps, file.remove))
  }
  if (!is_testthat_initialized()) {
    initializeTestthat(test_deps = c("checkmate", "sDevTest"))
  }
  assert_call(code, call_name = "{")
  lines<-wrap_snapshot(call_args(code))


  test_code = expr({
   !!!c(expr(local_edition(3)),lines)
  })
  out = expr_deparse(expr(test_that(!!name, !!test_code)))
  write(out, testpath)
  print(runTests(name, dev_version = TRUE))
  snaps <- paste0("tests/testthat/_snaps/", list.files("tests/testthat/_snaps/", pattern = name))
  n <- readline(prompt = "Keep Test? Enter 1 for yes: ")
  if (isTRUE(n != 1)) {
    file.remove(testpath)
    g_success("test file \"{testpath}\" deleted")
    if (nlen0(snaps))
      invisible(lapply(snaps, file.remove))
    g_success("snap file \"{snaps}\" deleted")
    g_stop("testing aborted")
  }
  if (is_dir_using_git() & commit_git) {
    add2Git(file = c(testpath, snaps), message = glue('added tests for "{name}"'
    ), push = push_github,
    bump_version = FALSE)
  }
  return(invisible(NULL))
  # Returns: invisible(NULL) Writes a test file to the tests/thatthat directory
}
#' @export
ignore=function(x){
 x
}
