test_that("make_fn_asssertion", {
  local_edition(3)
  x = expr(.(id = string(), name = string(), env = env(caller_env), args = named_list(
    structure = list(x = num(), y = num()))))
  expect_snapshot(make_fn_asssertion(x), cran = TRUE)
})
