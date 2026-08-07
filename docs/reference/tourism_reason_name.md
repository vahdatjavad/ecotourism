# Tourism Stopover Reason Names

A lookup table matching the stopover reason codes in
[`tourism_reason`](https://vahdatjavad.github.io/ecotourism/reference/tourism_reason.md)
to descriptive names.

## Usage

``` r
tourism_reason_name
```

## Format

A tibble with 7 rows and 2 variables: \* \*\*stop_reason\*\*: Integer
stopover reason code. \* \*\*name\*\*: Descriptive name of the stopover
reason.

## References

Tourism Research Australia: <https://www.tra.gov.au>

## See also

[`tourism_reason`](https://vahdatjavad.github.io/ecotourism/reference/tourism_reason.md)

## Examples

``` r
data(tourism_reason_name)
tourism_reason_name
#> # A tibble: 7 × 2
#>   stop_reason name                          
#>         <int> <chr>                         
#> 1           1 Holiday                       
#> 2           2 Visiting friends and relatives
#> 3           3 Business                      
#> 4           6 Other reason                  
#> 5           7 No other reason               
#> 6           8 In transit                    
#> 7           9 Not stated/not asked          
```
