# Tourism Stopover Activity Names

A lookup table matching the stopover activity codes in
[`tourism_activity`](https://vahdatjavad.github.io/ecotourism/reference/tourism_activity.md)
to descriptive names.

## Usage

``` r
tourism_activity_name
```

## Format

A tibble with 8 rows and 2 variables: \* \*\*stop_activity\*\*: Integer
stopover activity code. \* \*\*name\*\*: Descriptive name of the
stopover activity.

## References

Tourism Research Australia: <https://www.tra.gov.au>

## See also

[`tourism_activity`](https://vahdatjavad.github.io/ecotourism/reference/tourism_activity.md)

## Examples

``` r
data(tourism_activity_name)
tourism_activity_name
#> # A tibble: 8 × 2
#>   stop_activity name                                  
#>           <int> <chr>                                 
#> 1             1 Outdoor / nature                      
#> 2             2 Active outdoor / sports               
#> 3             3 Arts / heritage                       
#> 4             5 Local attractions / tourist activities
#> 5             6 Social activities                     
#> 6             7 None of these                         
#> 7             8 Not asked                             
#> 8             9 Other activities                      
```
