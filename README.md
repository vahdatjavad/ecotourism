
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ecotourism

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/ecotourism)](https://CRAN.R-project.org/package=ecotourism)
<!-- badges: end -->

The goal of ecotourism is to provide data to use for example analyses.
It has data on wild life (cuttlefish) occurrences, tourism counts by
region and weather matching the locations.

## Installation

You can install the development version of ecotourism from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("numbats/ecotourism")
```

## Example

Here is how to plot occurrences:

``` r
library(ecotourism)
library(ggplot2)
library(ggthemes)
data(oz_lga)
data(cuttlefish)
ggplot(oz_lga) +
  geom_sf(colour="white", fill="grey90") +
  geom_point(data=cuttlefish, aes(x=lon, y=lat,
                                  label=date),
             colour="#EA6900", alpha=0.5) +
  xlim(c(113.09, 153.38)) +
  ylim(c(-43.38, -10.41)) +
  theme_map()
#> Warning in geom_point(data = cuttlefish, aes(x = lon, y = lat, label = date), :
#> Ignoring unknown aesthetics: label
#> Warning: Removed 7 rows containing missing values or values outside the scale range
#> (`geom_point()`).
```

<img src="man/figures/README-example-1.png" width="100%" />
