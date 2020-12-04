test_that("g_info", {
  local_edition(3)
  type = "informative"
  expect_snapshot(g_info("this is a {type} message"), cran = TRUE)
})
