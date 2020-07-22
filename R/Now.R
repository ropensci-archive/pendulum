#' now 
#' 
#' @export
#' @param tzone (character) a valid time zone, defaults to your local timezone
#' @examples
#' x <- now()
#' x
#' x$time
#' x$date
#' x$utc
#' x$unix_epoch
#' x$min
#' x$sec
#' 
#' # mocking
#' Sys.Date()
#' clock_mock()
#' library(timefuzz)
#' mock <- time_fuzz$new()
#' ## set to today + 10 days
#' mock$freeze(Sys.Date() + 10)
#' z <- now()
#' z
#' z$time
#' z$date
#' z$utc
#' z$unix_epoch
#' z$min
#' z$sec
now <- function(tzone = "") {
  if (are_mocking()) {
    z <- timefuzz::Time
    z$inherit <- Now
    return(z$new())
  }
  Now$new(tzone)
}

Now <- R6::R6Class(
  "Now",
  lock_objects = FALSE,
  public = list(
    tzone = "",
    initialize = function(tzone = "") self$tzone = tzone,
    now = function() {
      if (are_mocking()) {
        return(self$now_with_mock_time())
      }
      adjust_tz(Sys.time(), self$tzone)
    }
  ),
  active = list(
    time = function() self$now(),
    date = function() as.Date(self$time),
    utc = function() adjust_tz(self$time, "UTC"),
    year = function() format(self$time, format = "%Y"),
    month = function() format(self$time, format = "%m"),
    day = function() format(self$time, format = "%d"),
    hour = function() format(selftime, format = "%H"),
    min = function() format(self$time, format = "%M"),
    sec = function() format(self$time, format = "%S"),
    utc_offset = function() format(self$time, format = "%z"),
    unix_epoch = function() as.numeric(self$time)
  )
)
