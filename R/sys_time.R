#' Mockable [Sys.time()] drop in replacement
#' @export
#' @return `POSIXct`, matching what [Sys.time()] returns
#' @seealso [sys_date()]
#' @examples
#' Sys.time()
#' sys_time()
#' 
#' clock_mock()
#' library(timefuzz)
#' x <- time_fuzz$new()
#' x$freeze(Sys.time() + 500)
#' sys_time()
#' clock_mock(FALSE)
#' sys_time()
sys_time <- function() {
  now()$now()
}
