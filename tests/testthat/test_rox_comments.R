library(sDevTools)
context("rox_comments")
test_that("rox_comments(\"these are roxygen comments\\n  more comments\\n  more comments\\n  @noRd\")", 
    {
        output <- {
            rox_comments("these are roxygen comments\n  more comments\n  more comments\n  @noRd")
        }
        expect_equal(test_summary(output), list(N = 4L, class = "character", 
            values = c("#' these are roxygen comments", "#' more comments", 
            "#' @noRd")))
    })
