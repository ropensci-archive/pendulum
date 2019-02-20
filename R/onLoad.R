clock_opts <- NULL # nocov start
.onLoad <- function(libname, pkgname){
	clock_opts <<- new.env()
	clock_opts$mock <<- FALSE
} # nocov end
