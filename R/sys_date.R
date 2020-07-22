#' Mockable [Sys.Date()] drop in replacement
#' @export
#' @return `Date`, matching what [Sys.Date()] returns
#' @seealso [sys_time()]
#' @examples
#' Sys.Date()
#' sys_date()
#' 
#' clock_mock()
#' library(timefuzz)
#' x <- time_fuzz$new()
#' x$freeze(Sys.Date() + 5)
#' sys_date()
#' clock_mock(FALSE)
#' sys_date()
sys_date <- function() {
  as.Date(as.POSIXlt(now()$now()))
}
