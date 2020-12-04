test_that("g_warn", {
  local_edition(3)
  type = "warning"
  expect_snapshot(g_warn("this is a {type}"), cran = TRUE)
})
