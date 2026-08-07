# Manta Ray Occurrence Data (2014–2024)

This dataset contains occurrence records for the reef manta ray
(\*Mobula alfredi\*) observed in Australian waters from 2014 to 2024.
The data includes spatial and temporal metadata, species identifiers,
and linked weather station IDs.

## Usage

``` r
manta_rays
```

## Format

A tibble with 1,088 rows and 14 variables:

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

  Scientific name — all observations are *Mobula alfredi*

- record_type:

  Type of observation (e.g., MACHINE_OBSERVATION)

- obs_state:

  Australian state where the observation occurred (may be missing)

- ws_id:

  Nearest weather station ID (e.g., "947800-99999")

## Source

Atlas of Living Australia via galah

## Details

Records were accessed using the galah package and filtered specifically
for \*Mobula alfredi\*. Data has been cleaned and enriched with spatial
proximity to weather stations for climate-related analysis.

## See also

[`gouldian_finch`](https://vahdatjavad.github.io/ecotourism/reference/gouldian_finch.md),
[`weather`](https://vahdatjavad.github.io/ecotourism/reference/weather.md)

## Examples

``` r
data(manta_rays)
head(manta_rays)
#> # A tibble: 6 × 14
#>   obs_lat obs_lon date       time      year month   day  hour weekday  dayofyear
#>     <dbl>   <dbl> <date>     <chr>    <dbl> <dbl> <dbl> <int> <ord>        <dbl>
#> 1   -33.9    151. 2014-01-04 00:00:00  2014     1     4     0 Saturday         4
#> 2   -33.9    151. 2015-07-28 00:00:00  2015     7    28     0 Tuesday        209
#> 3   -33.9    151. 2014-08-07 00:00:00  2014     8     7     0 Thursday       219
#> 4   -33.8    151. 2024-12-22 11:44:00  2024    12    22    11 Sunday         357
#> 5   -33.8    151. 2024-12-22 12:50:25  2024    12    22    12 Sunday         357
#> 6   -33.8    151. 2024-12-22 08:19:48  2024    12    22     8 Sunday         357
#> # ℹ 4 more variables: sci_name <chr>, record_type <chr>, obs_state <chr>,
#> #   ws_id <chr>
```
