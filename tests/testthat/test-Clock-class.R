test_that("Clock-class", {
  x <- Clock$new(2009, 3, 13, 1, 4, 53)
  expect_is(x, "Clock")
  
  # vars
  expect_is(x$time_, "POSIXt")
  
  # functions - now, date, and utc work with the current time/date
  # expect_equal(x$now(), Sys.time())
  expect_equal(x$date, as.Date("2009-03-13"))
  expect_equal(attr(x$utc, "tzone"), "UTC")
  # expect_equal(attr(x$now(), "tzone"), "")
  
  # active methods - IF a date set in $new(), works with that time/date
  expect_is(x$time, "POSIXt")
  expect_equal(as.character(x$time), "2009-03-13 01:04:53")

  expect_is(x$year, "character")
  expect_equal(x$year, "2009")

  expect_is(x$min, "character")
  expect_equal(x$min, "04")
})
