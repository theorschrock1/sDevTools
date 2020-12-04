#' Build a snapshot test.

#' @name build_snapshot_test
#' @param fn_name  \code{[string]}
#' @param code
#' @param overwrite  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param commit_git  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param push_github  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{build_snapshot_test}: invisible(NULL) Writes a test file to the tests/thatthat directory
#' @export
build_snapshot_test <- function(fn_name, code, overwrite = FALSE, commit_git = TRUE, push_github = TRUE) {
    # Build a snapshot test
    assert_string(fn_name)
    assert_logical(commit_git, len = 1)
    assert_logical(push_github, len = 1)
    assert_logical(overwrite, len = 1)
    code <- enexpr(code)
    testpath = glue("tests/testthat/test_{fn_name}.R")
    if (file.exists(testpath)) {
        if (overwrite == FALSE) 
            g_stop("test \"{fn_name}\" exists. Use \"overwrite=TRUE\" if this was intentional")
        snaps <- paste0("tests/testthat/_snaps/", list.files("tests/testthat/_snaps/", pattern = fn_name))
        if (nlen0(snaps)) 
            invisible(lapply(snaps, file.remove))
    }
    if (!is_testthat_initialized()) {
        initializeTestthat(test_deps = c("checkmate", "sDevTest"))
    }
    assert_call(enexpr(code), call_name = "{")
    find <- expr_extract_call(code, fn_name)
    if (len0(find)) {
        g_stop("function '{fn_name}' not found in code")
    }
    replacement <- lapply(find, function(x) expr(expect_snapshot(!!x, cran = TRUE)))
    test_code <- expr_find_replace_all(find, replacement, code, match.first = TRUE)
    test_code = expr({
        !!!c(expr(local_edition(3)), call_args(test_code))
    })
    out = expr_deparse(expr(test_that(!!fn_name, !!test_code)))
    write(out, testpath)
    print(runTests(fn_name, dev_version = TRUE))
    snaps <- paste0("tests/testthat/_snaps/", list.files("tests/testthat/_snaps/", pattern = fn_name))
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
        add2Git(file = c(testpath, snaps), message = "added tests for '{fn_name}'", push = push_github, 
            bump_version = FALSE)
    }
    return(invisible(NULL))
    # Returns: invisible(NULL) Writes a test file to the tests/thatthat directory
}
