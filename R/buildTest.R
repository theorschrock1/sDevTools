#' Auto build R code tests.

#' @name build_test
#' @param test_name  [character]  Must have an exact length of 1.
#' @param init  [call]  Initial code to run before testing. Must be a bracketed expr.  NULL is ok.
#' @param test_code  [call]   Must be a bracketed expr cotaining code to test in future.  Tests will be built based on the output of any expr that doesn't have an assignment. Usually this should be the function that the test is being built for.  All future tests will compare to the output of the code when build_test() was called.
#' @param test_file  [character] Should the test file name differ from the test name?   Defaults to NULL.  If NULL, the test_name will be used as the file name.  When build_test(), 2 files will be created.  One in the tests/testthat/ dir and one in the test_source_files directory.  If a test fails, the original code will be located in the test_source_files for inspection.
#' @param overwrite  [logical] Overwrite esixting test? Must have an exact length of 1.  Defaults to FALSE
#' @return \code{build_test}: [NULL]
#' @examples
#' build_test("sum",
#' init=NULL,
#' test_code={
#' sum(1:5)
#' sum(4:9)
#' sum(40:23)
#' })

#' @export
build_test <- function(test_name, init, test_code, test_file = NULL, overwrite = F,commit_git=TRUE,push_github=TRUE) {
  # Auto build R code tests
  if(!is_testthat_initialized()){
  initializeTestthat(test_deps=c("checkmate","sDevTest"))
  }
  assert_call = exprTools::assert_call
  init = enexpr(init)
  test_code = enexpr(test_code)
  assert_character(test_name, len = 1)
  assert_call(init, call_name = "{", null.ok = TRUE)
  assert_call(test_code, call_name = "{")
  assert_character(test_file, len = 1,null.ok=TRUE)
  assert_logical(overwrite, len = 1)
  ds = test_code %>% call_args() %>% sapply(exprTools::is_assignment) == F
  dts <- data.table(x = as.numeric(ds), exprs = test_code %>% call_args())
  dts[, `:=`(x, cumsum(shift(x, fill = 0)))]
  dls <- split(dts, by = "x", keep.by = FALSE)
  eval(init)
  t_names = sapply(dls, function(x) exprTools::exprs_deparse(x$exprs) %sep% "\n")
  tests <- lapply(dls, function(x) {
    code_expr = bracket_exprs(x$exprs)
    output = eval(code_expr)
    build_test_output(output, code_expr)
  })
  tests <- map2(t_names, tests, function(name, inner) {
    expr(test_that(!!name, {
      !!!inner
    }))
  })
  names(tests) = NULL
  if(!is.null(init)){
    test = c(expr(context(!!test_name)), call_args(init), tests)
  }else{
    test = c(expr(context(!!test_name)), tests)
  }
  out = lapply(test, deparse) %>% unlist(use.names = F)
  out = c(glue("library({current_pkg()})"), out)

  if (is.null(test_file))
    test_file = test_name
  if (!grepl("^test_", test_file))
    test_file = paste0("test_", test_file)
  pathout = paste0("~/", current_pkg(), "/tests/testthat/", test_file, ".R")
  if (file.exists(pathout) & overwrite == FALSE)
    g_stop("Test name '{test_name}' exists.  Use overwrite=TRUE to overwrite")
  print(glue("Writing '{test_name}' test to package '{current_pkg()}'"))
  writeLines(out, con = pathout)
  init_out = deparse(expr(init <- !!init))
  body = lapply(call_args(test_code), deparse) %>% unlist(use.names = F)
  source_out = c(glue("library({current_pkg()})"), init_out, body)
  pathout2 = paste0("~/", current_pkg(), "/test_source_files/", test_name, ".r")
  writeLines(source_out, con = pathout2)
  if(is_dir_using_git()&commit_git){
    add2Git(file=c(pathout,pathout2),message="added tests for '{test_name}'",push=push_github,bump_version = FALSE)
  }
  runTests(test_name)
  # Returns: [NULL]
}

