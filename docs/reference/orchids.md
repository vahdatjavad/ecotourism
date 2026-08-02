# Orchid Occurrence Data (2014–2024)

This dataset contains over 300,000 occurrence records of orchid species
(\*Orchidaceae\*) in Australia from 2014 to 2024. The data includes
spatial, temporal, and taxonomic details, as well as associated weather
station metadata for ecological analysis.

## Usage

``` r
orchids
```

## Format

A tibble with 302,123 rows and 14 variables:

- obs_lat:

  Latitude of the observation (decimal degrees)

- obs_lon:

  Longitude of the observation (decimal degrees)

- date:

  Date of the observation (YYYY-MM-DD)

- time:

  Time of the observation (HH:MM:SS)

- year:

  Year of the observation

- month:

  Month (1–12)

- day:

  Day of the month

- hour:

  Hour extracted from the time (0–23)

- weekday:

  Day of the week (as ordered factor)

- dayofyear:

  Day of the year (1–366)

- sci_name:

  Scientific name of the observed orchid species

- record_type:

  Type of observation (e.g., HUMAN_OBSERVATION, PRESERVED_SPECIMEN)

- obs_state:

  Australian state where the observation occurred (may be missing)

- ws_id:

  Nearest weather station ID linked to the observation

## Source

Atlas of Living Australia via galah

## Details

The data was collected using the galah package from the Atlas of Living
Australia, cleaned, and linked to nearby weather stations for ecological
and climatic studies. The records span multiple orchid genera and
include a range of observation types.

## See also

[`glowworms`](https://vahdatjavad.github.io/ecotourism/reference/glowworms.md),
[`gouldian_finch`](https://vahdatjavad.github.io/ecotourism/reference/gouldian_finch.md),
[`weather`](https://vahdatjavad.github.io/ecotourism/reference/weather.md)

## Examples

``` r
data(orchids)
head(orchids)
#> # A tibble: 6 × 14
#>   obs_lat obs_lon date       time      year month   day  hour weekday  dayofyear
#>     <dbl>   <dbl> <date>     <chr>    <dbl> <dbl> <dbl> <int> <ord>        <dbl>
#> 1   -35.2    118. 2017-09-11 18:08:00  2017     9    11    18 Monday         254
#> 2   -35.2    118  2019-08-02 12:38:00  2019     8     2    12 Friday         214
#> 3   -35.2    117. 2016-10-06 17:32:00  2016    10     6    17 Thursday       280
#> 4   -35.2    118. 2017-09-07 09:30:00  2017     9     7     9 Thursday       250
#> 5   -35.2    118. 2022-08-06 09:21:09  2022     8     6     9 Saturday       218
#> 6   -35.2    118. 2024-09-18 10:36:00  2024     9    18    10 Wednesd…       262
#> # ℹ 4 more variables: sci_name <chr>, record_type <chr>, obs_state <chr>,
#> #   ws_id <chr>
```
