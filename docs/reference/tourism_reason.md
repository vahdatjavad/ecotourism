# Monthly Tourism Trips by Stopover Reason

Estimated domestic overnight trips to Australian SA2 areas by month and
stopover reason. The data contain only observations with non-zero trip
estimates and non-zero survey sample sizes.

## Usage

``` r
tourism_reason
```

## Format

A tibble with 196,044 rows and 6 variables: \* \*\*year\*\*: Calendar
year, from 2014 to 2024. \* \*\*month\*\*: Ordered factor giving the
month returned from the trip. \* \*\*sa2_code_tra\*\*: Integer SA2 code
used by Tourism Research Australia. This can be joined to
[`tourism_region`](https://vahdatjavad.github.io/ecotourism/reference/tourism_region.md).
\* \*\*stop_reason\*\*: Integer reason code that can be joined to
[`tourism_reason_name`](https://vahdatjavad.github.io/ecotourism/reference/tourism_reason_name.md).
\* \*\*trips\*\*: Estimated number of overnight trips, in thousands. \*
\*\*n_sample\*\*: Number of survey responses supporting the estimate.

## Details

Records for which either `trips` or `n_sample` equals zero are excluded.
Estimates with small sample sizes should be interpreted with appropriate
caution.

## References

Tourism Research Australia: <https://www.tra.gov.au>

## See also

[`tourism_reason_name`](https://vahdatjavad.github.io/ecotourism/reference/tourism_reason_name.md),
[`tourism_activity`](https://vahdatjavad.github.io/ecotourism/reference/tourism_activity.md),
[`tourism_region`](https://vahdatjavad.github.io/ecotourism/reference/tourism_region.md)

## Examples

``` r
data(tourism_reason)
head(tourism_reason)
#> # A tibble: 6 × 6
#>    year month   sa2_code_tra stop_reason trips n_sample
#>   <int> <ord>          <int>       <int> <dbl>    <int>
#> 1  2014 January        11009           1  4.49        2
#> 2  2014 January        11009           2 14.7         3
#> 3  2014 January        11014           1  1.34        1
#> 4  2014 January        11014           2  6.86        2
#> 5  2014 January        11015           1  6.37        3
#> 6  2014 January        11015           2 12.5         3
```
