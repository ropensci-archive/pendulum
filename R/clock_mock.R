#' Mock time
#'
#' @export
#' @param on (logical) turn mocking on with `TRUE` or turn off with `FALSE`.
#' By default is `FALSE`
#' @details `timefuzz` package required for mocking behavior
#' @examples \dontrun{
#'
#' if (interactive()) {
#'   # load timefuzz
#'   library(timefuzz)
#'   library(clock)
#'
#'   # turn on mocking
#'   clock_mock()
#'
#'   # do stuff
#'   x <- clock()
#'   x$now()
#' 
#'   # turn off mocking
#'   clock_mock(FALSE)
#' }
#'
#' }
clock_mock <- function(on = TRUE) {
  check_for_package("timefuzz")
  clock_opts$mock <- on
}
