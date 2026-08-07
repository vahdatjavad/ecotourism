# Monthly Tourism Trips by Stopover Activity

Estimated domestic overnight trips to Australian SA2 areas by month and
stopover activity. The data contain only observations with non-zero trip
estimates and non-zero survey sample sizes.

## Usage

``` r
tourism_activity
```

## Format

A tibble with 320,188 rows and 6 variables: \* \*\*year\*\*: Calendar
year, from 2014 to 2024. \* \*\*month\*\*: Ordered factor giving the
month returned from the trip. \* \*\*sa2_code_tra\*\*: Integer SA2 code
used by Tourism Research Australia. This can be joined to
[`tourism_region`](https://vahdatjavad.github.io/ecotourism/reference/tourism_region.md).
\* \*\*stop_activity\*\*: Integer activity code that can be joined to
[`tourism_activity_name`](https://vahdatjavad.github.io/ecotourism/reference/tourism_activity_name.md).
\* \*\*trips\*\*: Estimated number of overnight trips, in thousands. \*
\*\*n_sample\*\*: Number of survey responses supporting the estimate.

## Details

Records for which either `trips` or `n_sample` equals zero are excluded.
Estimates with small sample sizes should be interpreted with appropriate
caution.

## References

Tourism Research Australia: <https://www.tra.gov.au>

## See also

[`tourism_activity_name`](https://vahdatjavad.github.io/ecotourism/reference/tourism_activity_name.md),
[`tourism_reason`](https://vahdatjavad.github.io/ecotourism/reference/tourism_reason.md),
[`tourism_region`](https://vahdatjavad.github.io/ecotourism/reference/tourism_region.md)

## Examples

``` r
data(tourism_activity)
head(tourism_activity)
#> # A tibble: 6 × 6
#>    year month   sa2_code_tra stop_activity trips n_sample
#>   <int> <ord>          <int>         <int> <dbl>    <int>
#> 1  2014 January        11009             1 15.6         2
#> 2  2014 January        11009             3  2.13        2
#> 3  2014 January        11009             5  2.13        2
#> 4  2014 January        11009             6 19.2         5
#> 5  2014 January        11014             6  6.86        2
#> 6  2014 January        11014             7  1.34        1
```
