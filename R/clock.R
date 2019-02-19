#' Clock class
#' 
#' @export
#' @param ... options to initializer
#' @param tzone (character) a valid time zone, defaults to your local timezone
#' @format NULL
#' @usage NULL
#' @details
#' **Methods**
#'   \describe{
#'     \item{`now(tzone = "")`}{
#'       get the date time right now
#'       param `tzone`: a valid time zone
#'     }
#'   }
#'
#' @return a [POSIXct] object
#' @examples
#' x <- Clock$new()
#' x
#' x$time
#' x$now()
#' x$utc()
#' x$now("UTC")
#' 
#' Clock$new(2009)$time
#' Clock$new(2009, 3, 13)$time
#' Clock$new(2009, 3, 13, 1, 4, 53)$time
#' 
#' clock_now()
#' clock_now("UTC")
Clock <- R6::R6Class(
  "Clock",
  public = list(
    time_ = NULL,
    initialize = function(...) {
      if (private$mocking()) {
        check_for_package("timefuzz")
        self <- timefuzz::Time$new()
      }

      parts <- list(...)
      if (length(parts) != 0)  {
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
      }
      return(self)
    },
    now = function(tzone = "") adjust_tz(Sys.time(), tzone),
    utc = function() self$now("UTC"),
    year = function() format(self$now(), format = "%Y"),
    month = function() format(self$now(), format = "%m"),
    day = function() format(self$now(), format = "%d"),
    hour = function() format(self$now(), format = "%H"),
    min = function() format(self$now(), format = "%M"),
    sec = function() format(self$now(), format = "%S"),
    utc_offset = function() format(self$now(), format = "%z")
  ),

  active = list(
    time = function() self$time_
  ),

  private = list(
    mocking = function() {
      if (clock_opts$mock) {
        check_for_package("timefuzz")
        return(TRUE)
      }
      return(FALSE)
    }
  )
)

#' @export
#' @rdname Clock
clock_now <- function(tzone = "", ...) Clock$new(...)$now(tzone)

parts_names <- c("year", "month", "day", "hour", "min", "sec", "tz")
