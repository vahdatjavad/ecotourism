# Top Weather Stations for Each Organism

A lookup table identifying the top 3 most frequently linked weather
stations for each focal organism in the ecotourism package. These
stations were selected based on the number of linked observations across
a 10-year period (2014–2024).

## Usage

``` r
top_stations
```

## Format

A tibble with 12 rows and 2 variables:

- organism:

  Name of the organism (e.g., "glowworms", "orchids")

- ws_id:

  Weather station ID (e.g., "948720-99999")

## Details

This table was created by counting the frequency of \`ws_id\`
assignments within each organism dataset and selecting the top 3
stations per organism. These top stations are used for downloading daily
weather data via the GSODR package.

## See also

[`weather`](https://vahdatjavad.github.io/ecotourism/reference/weather.md),
[`weather_stations`](https://vahdatjavad.github.io/ecotourism/reference/weather_stations.md)

## Examples

``` r
data(top_stations)
head(top_stations)
#> # A tibble: 6 × 2
#>   organism       ws_id       
#>   <chr>          <chr>       
#> 1 orchids        946300-99999
#> 2 orchids        956470-99999
#> 3 orchids        956410-99999
#> 4 gouldian_finch 941310-99999
#> 5 gouldian_finch 941200-99999
#> 6 gouldian_finch 952140-99999
```
