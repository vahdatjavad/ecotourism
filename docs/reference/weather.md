# Daily Weather Data for Top Stations (2014–2024)

This dataset contains daily weather observations for the top weather
stations associated with focal species in the ecotourism package. Data
spans from 2014 to 2024 and includes temperature, humidity,
precipitation, and wind measures.

## Usage

``` r
weather
```

## Format

A tibble with 35,527 rows and 18 variables:

- ws_id:

  Weather station ID (e.g., "948720-99999")

- stn_lat:

  Latitude of the weather station

- stn_lon:

  Longitude of the weather station

- date:

  Observation date (YYYY-MM-DD)

- year:

  Year of observation

- month:

  Month of observation (1–12)

- day:

  Day of the month

- weekday:

  Day of the week (as ordered factor)

- dayofyear:

  Day of the year (1–366)

- temp:

  Average temperature (°C)

- min:

  Minimum temperature (°C)

- max:

  Maximum temperature (°C)

- dewp:

  Dew point temperature (°C)

- rh:

  Relative humidity (%)

- prcp:

  Precipitation (mm)

- rainy:

  Binary flag indicating whether PRCP \> 5 mm (1 = rainy day)

- wind_speed:

  Average wind speed (m/s)

- max_speed:

  Maximum sustained wind speed (m/s)

## Source

GSOD via GSODR

## Details

The weather data was retrieved from the Global Surface Summary of the
Day (GSOD) dataset via the GSODR package for the top 3 weather stations
per organism in the ecotourism project. This data supports
climate-biodiversity interaction analyses.

## See also

[`top_stations`](https://vahdatjavad.github.io/ecotourism/reference/top_stations.md),
[`glowworms`](https://vahdatjavad.github.io/ecotourism/reference/glowworms.md),
[`gouldian_finch`](https://vahdatjavad.github.io/ecotourism/reference/gouldian_finch.md),
[`weather_stations`](https://vahdatjavad.github.io/ecotourism/reference/weather_stations.md)

## Examples

``` r
data(weather)
head(weather)
#> # A tibble: 6 × 18
#>   ws_id     stn_lat stn_lon date        year month   day weekday dayofyear  temp
#>   <chr>       <dbl>   <dbl> <date>     <dbl> <dbl> <int> <ord>       <dbl> <dbl>
#> 1 941200-9…   -12.4    131. 2014-01-01  2014     1     1 Wednes…         1  30.1
#> 2 941200-9…   -12.4    131. 2014-01-02  2014     1     2 Thursd…         2  30.5
#> 3 941200-9…   -12.4    131. 2014-01-03  2014     1     3 Friday          3  30.5
#> 4 941200-9…   -12.4    131. 2014-01-04  2014     1     4 Saturd…         4  29.5
#> 5 941200-9…   -12.4    131. 2014-01-05  2014     1     5 Sunday          5  28.9
#> 6 941200-9…   -12.4    131. 2014-01-06  2014     1     6 Monday          6  30.4
#> # ℹ 8 more variables: min <dbl>, max <dbl>, dewp <dbl>, rh <dbl>, prcp <dbl>,
#> #   rainy <int>, wind_speed <dbl>, max_speed <dbl>
```
