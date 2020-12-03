test_that("g_success", {
  local_edition(3)
  expect_snapshot(g_success("Success"), cran = TRUE)
  your_name = "Bob"
  expect_snapshot(g_success("Your name is {your_name}"), cran = TRUE)
})
