test_that("rox_comments", {
  local_edition(3)
  expect_snapshot(rox_comments(
    "these are roxygen comments\n  more comments\n  more comments\n  @noRd"),
  cran = TRUE)
})
