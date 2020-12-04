test_that("g_danger", {
  local_edition(3)
  type = "dangerous"
  expect_snapshot(g_danger("this is a {type} message"), cran = TRUE)
})
