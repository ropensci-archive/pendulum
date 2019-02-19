adjust_tz <- function(time, tzone = "") {
  new <- if (inherits(time, "POSIXlt")) {
    as.POSIXct(time)
  } else {
    time
  }
  attr(new, "tzone") <- tzone
  return(new)
}
