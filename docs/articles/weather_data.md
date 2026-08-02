# Weather Data

## 1 Introduction

This vignette demonstrates the use of two datasets: `top_stations` and
`weather`. After selecting an organism of interest, we linked each
occurrence to its nearest weather station. We then counted the matches,
identified the top three weather stations most closely associated with
the organism’s occurrences, and downloaded the corresponding weather
data for further analysis.

------------------------------------------------------------------------

This is the glimpse of your `top_stations` data :

``` r

library(dplyr)
library(ecotourism)

data("top_stations")
top_stations |> glimpse()
```

    Rows: 12
    Columns: 2
    $ organism <chr> "orchids", "orchids", "orchids", "gouldian_finch", "gouldian_…
    $ ws_id    <chr> "946300-99999", "956470-99999", "956410-99999", "941310-99999…

and this is `weather` data related to those top stations:

``` r

data("weather")
weather |> glimpse()
```

    Rows: 46,390
    Columns: 18
    $ ws_id      <chr> "941200-99999", "941200-99999", "941200-99999", "941200-999…
    $ stn_lat    <dbl> -12.415, -12.415, -12.415, -12.415, -12.415, -12.415, -12.4…
    $ stn_lon    <dbl> 130.877, 130.877, 130.877, 130.877, 130.877, 130.877, 130.8…
    $ date       <date> 2014-01-01, 2014-01-02, 2014-01-03, 2014-01-04, 2014-01-05…
    $ year       <dbl> 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014,…
    $ month      <dbl> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,…
    $ day        <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, …
    $ weekday    <ord> Wednesday, Thursday, Friday, Saturday, Sunday, Monday, Tues…
    $ dayofyear  <dbl> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, …
    $ temp       <dbl> 30.06667, 30.50764, 30.49792, 29.54028, 28.89375, 30.40556,…
    $ min        <dbl> 27.10000, 28.00000, 27.36667, 25.50000, 25.01667, 26.66667,…
    $ max        <dbl> 33.00000, 32.93333, 33.50000, 33.00000, 33.86667, 35.43333,…
    $ dewp       <dbl> 25.50694, 24.81736, 24.61736, 22.85694, 23.83889, 24.06333,…
    $ rh         <dbl> 77.24566, 72.17120, 71.94775, 67.80264, 75.49793, 70.78035,…
    $ prcp       <dbl> 0.0, 0.0, 0.0, 0.0, 5.0, 0.0, 0.0, 0.0, 0.0, 0.2, 4.0, 14.0…
    $ rainy      <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1,…
    $ wind_speed <dbl> 4.333333, 4.307639, 4.332639, 4.727431, 4.469792, 3.678403,…
    $ max_speed  <dbl> 6.866667, 5.866667, 7.700000, 7.700000, 7.733333, 5.700000,…

------------------------------------------------------------------------

Map of Top Weather Stations

``` r

library(ggplot2)
library(ggthemes)

top_stations |> left_join(weather_stations) |> 
ggplot() +
  geom_sf(data = oz_sa2) +
  geom_point(aes(x = stn_lon, y = stn_lat, color = organism), shape = 17, size = 3) +
  theme_map()
```

------------------------------------------------------------------------
