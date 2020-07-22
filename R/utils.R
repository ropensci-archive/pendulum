adjust_tz <- function(time, tzone = "") {
  new <- if (inherits(time, "POSIXlt")) {
    as.POSIXct(time)
  } else {
    time
  }
  attr(new, "tzone") <- tzone
  return(new)
}

# are we in mocking mode?
# return: boolean
are_mocking <- function() {
  if (clock_opts$mock) {
    check_for_package("timefuzz")
    return(TRUE)
  }
  return(FALSE)
}
