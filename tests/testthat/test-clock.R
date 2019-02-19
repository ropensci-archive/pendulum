context("clock")

test_that("clock", {
  expect_is(Clock, "R6ClassGenerator")
  expect_is(Clock$new(), "Clock")
})
