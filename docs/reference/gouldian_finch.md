# Gouldian Finch Occurrence Data (2014–2024)

This dataset contains cleaned and processed occurrence records for the
Gouldian Finch (\*Chloebia gouldiae\*) in Australia between 2014 and
2024. It includes spatial coordinates, temporal details, species
information, and the ID of the nearest weather station for each
observation.

## Usage

``` r
gouldian_finch
```

## Format

A tibble with 3,921 rows and 14 variables:

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

  Scientific name of the species

- record_type:

  Type of observation (e.g., HUMAN_OBSERVATION)

- obs_state:

  Australian state where the observation was recorded

- ws_id:

  Nearest weather station ID (e.g., "948280-99999")

## Source

Atlas of Living Australia via galah

## Details

The data was retrieved from the Atlas of Living Australia using the
galah package, then standardized, cleaned, and matched to the three
closest weather stations using geospatial tools.

## See also

[`glowworms`](https://vahdatjavad.github.io/ecotourism/reference/glowworms.md),
[`weather`](https://vahdatjavad.github.io/ecotourism/reference/weather.md)

## Examples

``` r
data(gouldian_finch)
head(gouldian_finch)
#> # A tibble: 6 × 14
#>   obs_lat obs_lon date       time      year month   day  hour weekday  dayofyear
#>     <dbl>   <dbl> <date>     <chr>    <dbl> <dbl> <dbl> <int> <ord>        <dbl>
#> 1   -38.3    142. 2015-01-25 15:15:00  2015     1    25    15 Sunday          25
#> 2   -35.5    139. 2021-01-03 15:01:16  2021     1     3    15 Sunday           3
#> 3   -35.4    149. 2016-12-13 10:30:00  2016    12    13    10 Tuesday        348
#> 4   -33.8    151. 2014-04-24 00:00:00  2014     4    24     0 Thursday       114
#> 5   -33.8    151. 2014-04-24 00:00:00  2014     4    24     0 Thursday       114
#> 6   -33.8    151. 2014-04-24 00:00:00  2014     4    24     0 Thursday       114
#> # ℹ 4 more variables: sci_name <chr>, record_type <chr>, obs_state <chr>,
#> #   ws_id <chr>
```
