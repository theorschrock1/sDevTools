
sDevTools::loadUtils()
local_edition(3)
test_that("checkUsageFn", {
  fn=function(x){ hello(s)}
  expect_snapshot_output(checkUsageFn(fn,package = 'sDevTools'))
})
