# Australia Weather Station

## 1 Introduction

This vignette introduces the `weather_stations` dataset, obtained from
the GSODR package. These stations provide essential information for
understanding long-term climate patterns, making them a valuable
resource for ecotourism studies.

------------------------------------------------------------------------

## 2 Preview of Weather Station Data

This is the glimpse of your data :

``` r

library(dplyr)
library(ecotourism)

data("weather_stations")
weather_stations |> glimpse()
```

    Rows: 732
    Columns: 7
    $ ws_id     <chr> "941000-99999", "941020-99999", "941030-99999", "941050-9999…
    $ stname    <chr> "KALUMBURU", "TROUGHTON ISLAND", "BROWSE ISLAND AWS", "NOONA…
    $ stn_lat   <dbl> -14.300, -13.750, -14.117, -12.617, -14.717, -11.167, -11.55…
    $ stn_lon   <dbl> 126.633, 126.150, 123.533, 131.050, 134.750, 132.483, 132.92…
    $ address   <chr> "Drysdale River, Shire Of Wyndham-East Kimberley, Western Au…
    $ stn_city  <chr> "Drysdale River", "Troughton Island Airport", "Shire Of Wynd…
    $ stn_state <chr> "Western Australia", "Western Australia", "Western Australia…

------------------------------------------------------------------------

## 3 Visualization: Map of Weather Stations

``` r

library(ggplot2)
library(ggthemes)

ggplot() +
  geom_sf(data = oz_sa2) +
  geom_point(data = weather_stations, 
             aes(x = stn_lon, y = stn_lat, colour = stn_state),
             alpha = 0.6, size = 1) +
  theme_map() +
  theme(legend.position = "none")
```
