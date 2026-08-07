# Australian Statistical Area Level 2 Boundaries

Simplified 2021 Statistical Area Level 2 (SA2) polygon boundaries for
the SA2 codes used in Tourism Research Australia exports. Representative
interior-point coordinates are included for analyses that need one point
per SA2.

## Usage

``` r
oz_sa2
```

## Format

An `sf` data frame with 2,350 rows and 4 variables: \*
\*\*sa2_code_tra\*\*: Integer SA2 identifier used by Tourism Research
Australia. This field can be joined to
[`tourism_reason`](https://vahdatjavad.github.io/ecotourism/reference/tourism_reason.md),
[`tourism_activity`](https://vahdatjavad.github.io/ecotourism/reference/tourism_activity.md),
and
[`tourism_region`](https://vahdatjavad.github.io/ecotourism/reference/tourism_region.md).
\* \*\*lat\*\*: Latitude of a representative point located within the
SA2, in decimal degrees. \* \*\*lon\*\*: Longitude of a representative
point located within the SA2, in decimal degrees. \* \*\*geometry\*\*:
Simplified SA2 polygon or multipolygon geometry in GDA2020 (EPSG:7844).

## Source

Australian Bureau of Statistics, [ASGS Edition 3 digital boundary
files](https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files).

## Details

Boundaries were obtained from the Australian Bureau of Statistics ASGS
Edition 3 digital boundary files. Full-resolution polygons were matched
to TRA codes by state and SA2 name. Representative points were
calculated from the full-resolution geometry in Australian Albers
(EPSG:3577), using a point guaranteed to lie on the SA2 surface. Polygon
geometry was simplified with rmapshaper, retaining five percent of
removable vertices while preserving shapes and shared boundaries.

## References

Australian Bureau of Statistics. Australian Statistical Geography
Standard (ASGS), Edition 3, July 2021–June 2026.

## See also

[`tourism_region`](https://vahdatjavad.github.io/ecotourism/reference/tourism_region.md),
[`tourism_reason`](https://vahdatjavad.github.io/ecotourism/reference/tourism_reason.md),
[`tourism_activity`](https://vahdatjavad.github.io/ecotourism/reference/tourism_activity.md)

## Examples

``` r
data(oz_sa2)
head(oz_sa2)
#> Error in FUN(X[[i]], ...): `x` must be a vector, not a <sfc_MULTIPOLYGON> object.
#> ✖ Detected incompatible scalar S3 list. To be treated as a vector, the object must explicitly inherit from <list> or should implement a `vec_proxy()` method. Class: <sfc_MULTIPOLYGON/sfc>.
#> ℹ If this object comes from a package, please report this error to the package author.
#> ℹ Read our FAQ about creating vector types (`?vctrs::howto_faq_fix_scalar_type_error`) to learn more.
```
