clock
=====


[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![Build Status](https://travis-ci.com/ropensci/clock.svg?branch=master)](https://travis-ci.com/ropensci/clock)

Time classes for R, w/ time mocking capability via [timefuzz][]

**Why?** - Some programming languages support [monkey patching][monkey]. However, R does not officially allow this (there's a way to do it, but it's a hack). Therefore, the only way that I can think of to "mock time" is to use a different set of time classes/objects. That is, we can't just mock time using `Sys.Date()` directly as there's no way to monkey patch the code behind that function.  Some may say it's good that R doesn't officially support monkey patching; there's definitely upsides; but a downside is that mocking things like time becomes difficult.

- `clock()` is designed for setting a specific time
- `now()` is designed for getting the current time AND is mockable
- `sys_time()` and `sys_date()` are drop in replacements for `Sys.time()` and `Sys.Date()` AND are mockable

See the docs to get started: https://docs.ropensci.org/clock

## Installation


```r
remotes::install_github("ropensci/clock")
```


```r
library(clock)
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/clock/issues).
* License: MIT
* Get citation information for `clock` in R doing `citation(package = 'clock')`
* Please note that this package is released with a [Contributor Code of Conduct](https://ropensci.org/code-of-conduct/). By contributing to this project, you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)

[timefuzz]: https://github.com/ropensci/timefuzz
[monkey]: https://en.wikipedia.org/wiki/Monkey_patch
