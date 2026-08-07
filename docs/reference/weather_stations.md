# Australian Weather Station Metadata

This dataset contains metadata for 732 weather stations across
Australia, including coordinates, station names, and geocoded location
details.

## Usage

``` r
weather_stations
```

## Format

A tibble with 732 rows and 7 variables:

- ws_id:

  Weather station ID (e.g., "941000-99999")

- stname:

  Station name (e.g., "KALUMBURU")

- stn_lat:

  Latitude of the station (decimal degrees)

- stn_lon:

  Longitude of the station (decimal degrees)

- address:

  Full geocoded address (from reverse geocoding)

- stn_city:

  Parsed city or locality name

- stn_state:

  Australian state or territory

## Source

GSOD inventory via GSODR; geocoded with OpenStreetMap

## Details

This data was derived from the GSOD inventory using the GSODR package,
filtered for Australian stations, and geocoded using OpenStreetMap APIs.
It is used to match ecological observations with relevant local weather
conditions.

## See also

[`weather`](https://vahdatjavad.github.io/ecotourism/reference/weather.md),
[`top_stations`](https://vahdatjavad.github.io/ecotourism/reference/top_stations.md),
[`gouldian_finch`](https://vahdatjavad.github.io/ecotourism/reference/gouldian_finch.md)

## Examples

``` r
data(weather_stations)
head(weather_stations)
#> # A tibble: 6 × 7
#>   ws_id        stname                stn_lat stn_lon address  stn_city stn_state
#>   <chr>        <chr>                   <dbl>   <dbl> <chr>    <chr>    <chr>    
#> 1 941000-99999 KALUMBURU               -14.3    127. Drysdal… Drysdal… Western …
#> 2 941020-99999 TROUGHTON ISLAND        -13.8    126. Trought… Trought… Western …
#> 3 941030-99999 BROWSE ISLAND AWS       -14.1    124. Shire O… Shire O… Western …
#> 4 941050-99999 NOONAMAH AIRSTRIP       -12.6    131. Jenkins… Jenkins… Northern…
#> 5 941060-99999 NGUKURR AIRPORT         -14.7    135. Ngukurr… Ngukurr  Northern…
#> 6 941080-99999 CROKER ISLAND AIRPORT   -11.2    132. Airport… Airport… Northern…
```
