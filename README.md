
<!-- README.md is generated from README.Rmd. Please edit that file -->

# potemkin

<!-- badges: start -->
<!-- badges: end -->

The goal of potemkin is to raise a middle finger to the
bureaucratization of science.

## Installation

You can install the development version of potemkin like so:

``` r
devtools::install_github("skvrnami/potemkin")
```

## Example

Does someone makes you fill pointless Excel spreadsheets with work
report that no one will ever read but it is still required. No worries,
`potemkin` package got you covered. Function `get_timesheet` will
generate random distribution of your work hours into specified activity
categories.

``` r
library(potemkin)

get_timesheet(c("admin", "research activities", "study of literature"), 
              n_hours = 40)
#>              activity hours
#> 1               admin  17.3
#> 2 research activities  14.4
#> 3 study of literature   8.3
```

If you want to specify particular time spent on any activity, you can do
so by using `specified_activities` parameter.

``` r
get_timesheet(c("admin", "research activities", "study of literature"), 
              n_hours = 40, 
              specified_activities = list(meeting = 2))
#>              activity hours
#> 1               admin  12.0
#> 2 research activities  15.4
#> 3 study of literature  10.6
#> 4             meeting   2.0
```
