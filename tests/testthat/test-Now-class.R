test_that("Now-class", {
  expect_is(Now, "R6ClassGenerator")

  x <- Now$new()
  expect_is(x, "Now")
  
  # vars
  expect_equal(x$tzone, "")
  
  # functions
  expect_is(x$now, "function")
  expect_equal(x$now(), Sys.time())
  expect_equal(x$date, as.Date(Sys.time()))
  expect_equal(attr(x$utc, "tzone"), "UTC")
  expect_equal(attr(x$now(), "tzone"), "")
  
  # active methods
  expect_is(x$year, "character")
  expect_equal(x$year, format(Sys.Date(), format="%Y"))

  expect_is(x$min, "character")
  expect_equal(x$min, format(Sys.time(), format="%M"))
})
