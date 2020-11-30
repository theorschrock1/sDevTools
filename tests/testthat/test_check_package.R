library(sDevTools)
context("check_package")
test_that("check_package(\"data.table\")", {
    output <- {
        check_package("data.table")
    }
    expect_equal(test_summary(output), list(N = 1L, class = "logical", 
        values = TRUE))
})
test_that("check_package(\"rlang\")", {
    output <- {
        check_package("rlang")
    }
    expect_equal(test_summary(output), list(N = 1L, class = "logical", 
        values = TRUE))
})
test_that("check_package(\"a_non_existing_package\")", {
    output <- {
        check_package("a_non_existing_package")
    }
    expect_equal(test_summary(output), list(N = 1L, class = c("glue", 
    "character"), values = "package namespace:\"a_non_existing_package\" not installed"))
})
