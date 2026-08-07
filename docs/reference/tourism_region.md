# Tourism Regions and Nearest Weather Stations

A dataset containing the locations of Australian tourism regions, their
geographic coordinates, and the nearest Bureau of Meteorology weather
station. Each region is assigned a unique identifier for linking to
other tourism datasets.

## Usage

``` r
tourism_region
```

## Format

A tibble with 2,353 rows and 7 variables: \* \*\*state\*\*: Australian
state or territory abbreviation. \* \*\*region\*\*: Name of the tourism
region. Tourism regions are defined by Tourism Research Australia and
generally formed through the aggregation of Statistical Area Level 2
(SA2) geographies. \* \*\*sa2\*\*: Name of the SA2 area. \* \*\*lon\*\*:
Longitude of the SA2 representative point (WGS84). \* \*\*lat\*\*:
Latitude of the SA2 representative point (WGS84). \* \*\*ws_id\*\*:
Identifier of the nearest Bureau of Meteorology weather station to the
SA2 area. \* \*\*sa2_code_tra\*\*: Character SA2 code used by Tourism
Research Australia. Join this field to the identically named field in
the detailed tourism datasets after harmonising its type.

## Details

Coordinates for each SA2 are intended to represent a central location
within the area (e.g., polygon centroid). The nearest weather station is
determined using great-circle distance calculations based on the Bureau
of Meteorology's official station list.

## References

Tourism Research Australia: <https://www.tra.gov.au> Australian Bureau
of Meteorology.

## Examples

``` r
data(tourism_region)
head(tourism_region)
#> # A tibble: 6 × 7
#>   state region   sa2                lon   lat ws_id        sa2_code_tra
#>   <chr> <chr>    <chr>            <dbl> <dbl> <chr>        <chr>       
#> 1 ACT   Canberra ACT - South West  149. -35.4 949250-99999 81140       
#> 2 ACT   Canberra Acton             145. -37.9 948650-99999 81049       
#> 3 ACT   Canberra Ainslie           149. -35.3 949260-99999 81050       
#> 4 ACT   Canberra Amaroo            149. -35.2 949260-99999 81034       
#> 5 ACT   Canberra Aranda            146. -16.8 942870-99999 81001       
#> 6 ACT   Canberra Banks             149. -35.5 949250-99999 81071       
```
