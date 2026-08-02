# Glowworms Occurrence Data (2014–2024)

This dataset contains cleaned and enriched occurrence records for
glowworms (\*Arachnocampa tasmaniensis\*) in Australia from 2014 to
2024. It includes spatial, temporal, taxonomic, and weather station
metadata.

## Usage

``` r
glowworms
```

## Format

A tibble with 124 rows and 14 variables:

- obs_lat:

  Latitude of the observation (decimal degrees)

- obs_lon:

  Longitude of the observation (decimal degrees)

- date:

  Observation date (YYYY-MM-DD)

- time:

  Observation time (HH:MM:SS, character)

- year:

  Observation year

- month:

  Month of the observation

- day:

  Day of the month

- hour:

  Hour of the day (0–23)

- weekday:

  Day of the week (ordered factor)

- dayofyear:

  Day of the year (1–366)

- sci_name:

  Scientific name of the observed species

- record_type:

  Type of observation (e.g., HUMAN_OBSERVATION)

- obs_state:

  Australian state where the observation occurred

- ws_id:

  ID of the nearest weather station (e.g., "949610-99999")

## Source

Atlas of Living Australia via galah

## Details

Data was sourced via the \`galah\` package from the Atlas of Living
Australia, filtered and cleaned, then enriched by linking each record to
the nearest weather station using geospatial methods.

## Examples

``` r
data(glowworms)
head(glowworms)
#> # A tibble: 6 × 14
#>   obs_lat obs_lon date       time      year month   day  hour weekday  dayofyear
#>     <dbl>   <dbl> <date>     <chr>    <dbl> <dbl> <dbl> <int> <ord>        <dbl>
#> 1   -43.5    147. 2021-12-14 22:14:23  2021    12    14    22 Tuesday        348
#> 2   -43.5    147. 2015-12-09 15:00:24  2015    12     9    15 Wednesd…       343
#> 3   -43.5    147. 2017-04-17 13:31:00  2017     4    17    13 Monday         107
#> 4   -43.5    147. 2023-12-21 14:18:00  2023    12    21    14 Thursday       355
#> 5   -43.5    147. 2022-12-26 18:42:12  2022    12    26    18 Monday         360
#> 6   -42.8    147. 2024-12-05 11:36:00  2024    12     5    11 Thursday       340
#> # ℹ 4 more variables: sci_name <chr>, record_type <chr>, obs_state <chr>,
#> #   ws_id <chr>
```
