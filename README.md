clock
=====



[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.com/ropenscilabs/clock.svg?branch=master)](https://travis-ci.com/ropenscilabs/clock)

Time classes for R, w/ time mocking capability via [timefuzz][]

**BEWARE: VERY ALPHA**

**Why?** - Some programming languages support [monkey patching][monkey]. However, R does not officially allow this (there's a way to do it, but it's a hack). Therefore, the only way that I can think of to "mock time" is to use a different set of time classes/objects. That is, we can't just mock time using `Sys.Date()` directly as there's no way to monkey patch the code behind that function.  Some may say it's good that R doesn't officially support monkey patching; there's definitely upsides; but a downside is that mocking things like time becomes difficult.

Package API:

 - `sys_date`
 - `now`
 - `clock_mock`
 - `clock`
 - `sys_time`

## Installation


```r
remotes::install_github("ropenscilabs/clock")
```


```r
library(clock)
```

## usage


```r
clock(2009)$time
#> [1] "2009-01-01 12:00:00 PST"
clock(2009, 3, 13)$time
#> [1] "2009-03-13 12:00:00 PDT"
clock(2009, 3, 13, 1, 4, 53)$time
#> [1] "2009-03-13 01:04:53 PDT"
```


```r
x <- clock(2009, 3, 13)
x$utc
#> [1] "2009-03-13 19:00:00 UTC"
x$date
#> [1] "2009-03-13"
```


```r
now()$now()
#> [1] "2020-07-21 17:14:03 PDT"
now("UTC")$now()
#> [1] "2020-07-22 00:14:03 UTC"
```

## use in a function


```r
todays_date <- function() sys_time()
todays_date()
#> [1] "2020-07-21 17:14:03 PDT"
```

now let's mock time


```r
library(timefuzz)
x <- time_fuzz$new()
## set to today + 5 days
x$freeze(Sys.Date() + 5)
todays_date()
#> [1] "2020-07-25 17:00:00 PDT"
# if you run it again, you get the same EXACT time
todays_date()
#> [1] "2020-07-25 17:00:00 PDT"
```

"unfreeze" and you're back to real time


```r
x$unfreeze()
todays_date()
#> [1] "2020-07-21 17:14:03 PDT"
Sys.sleep(1)
todays_date()
#> [1] "2020-07-21 17:14:04 PDT"
Sys.sleep(1)
todays_date()
#> [1] "2020-07-21 17:14:05 PDT"
```


## Meta

* Please [report any issues or bugs](https://github.com/ropenscilabs/clock/issues).
* License: MIT
* Get citation information for `clock` in R doing `citation(package = 'clock')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[timefuzz]: https://github.com/ropenscilabs/timefuzz
[monkey]: https://en.wikipedia.org/wiki/Monkey_patch
