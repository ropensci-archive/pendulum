#' Clock class
#' 
#' @export
#' @param ... date parts, must be supplied in order (i.e., if you want to give
#' seconds, you must give all others first): year, month, day, hour, minutes,
#' seconds. uses [ISOdate()] internally to convert to a `POSIXct`. optional;
#' if nothing supplied, the current time is used.
#' @details
#' **Methods**
#' These must be called with parens
#'   \describe{
#'     \item{`now(tzone = "")`}{
#'       Get the date time right now
#'       param `tzone`: a valid time zone
#'     }
#'     \item{`date()`}{
#'       Same as $now() but as a `Date` class
#'     }
#'     \item{`utc()`}{
#'       Same as $now() but with time zone set to UTC
#'     }
#'   }
#' 
#' **Active Methods**
#' These are called without parens
#'   \describe{
#'     \item{`time`}{
#'       Get the current time or the time you set on initialize
#'     }
#'     \item{`year`}{
#'       Get the year component of the time
#'     }
#'     \item{`month`}{
#'       Get the month component of the time
#'     }
#'     \item{`day`}{
#'       Get the day component of the time
#'     }
#'     \item{`hour`}{
#'       Get the hour component of the time
#'     }
#'     \item{`min`}{
#'       Get the minute component of the time
#'     }
#'     \item{`sec`}{
#'       Get the seconds component of the time
#'     }
#'     \item{`utc_offset`}{
#'       Get the utc offset
#'     } 
#'     \item{`unix_epoch`}{
#'       Get the time in seconds since unix epoch
#'     } 
#'   }
#'
#' @return a [POSIXct] object
#' @examples
#' # if no time set when initialized
#' ## uses current time when you call functions with parens
#' x <- clock(2009)
#' x
#' ## and uses current time when you call active functions
#' x$utc
#' x$date
#' x$year
#' x$month
#'  
#' # if time set when initialized
#' ## ignores that time when calling functions with parens
#' z <- clock(2009, 3, 13)
#' z
#' z$utc
#' ## and uses the user set time when you call active functions
#' z$year
#' z$month
#' z$utc_offset
#' z$unix_epoch
#' 
#' # 
#' clock(2009)$time
#' clock(2009, 3, 13)$time
#' clock(2009, 3, 13, 1, 4, 53)$time
#' 
#' now()
#' now("UTC")
clock <- function(...) {
  if (are_mocking()) {
    z <- timefuzz::Time
    z$inherit <- Clock
    return(z$new(...))
  }
  Clock$new(...)
}

Clock <- R6::R6Class(
  "Clock",
  lock_objects = FALSE,
  public = list(
    time_ = NULL,
    initialize = function(...) {
      parts <- list(...)
      if (length(parts) == 0) stop("no date parts supplied", call.=FALSE)
      len <- 7 - length(parts)
      parts <- c(parts, vector("list", length = len))
      parts <- stats::setNames(parts, parts_names)
      if (is.null(parts$year)) parts$year <- self$year()
      if (is.null(parts$month)) parts$month <- 1
      if (is.null(parts$day)) parts$day <- 1
      if (is.null(parts$hour)) parts$hour <- 12
      if (is.null(parts$min)) parts$min <- 0
      if (is.null(parts$sec)) parts$sec <- 0
      if (is.null(parts$tz)) parts$tz <- Sys.getenv("TZ")
      self$time_ <- do.call(ISOdate, parts)
      return(self)
    }
  ),

  active = list(
    time = function() self$time_,
    date = function() as.Date(self$time_),
    utc = function() adjust_tz(self$time_, "UTC"),
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

parts_names <- c("year", "month", "day", "hour", "min", "sec", "tz")
