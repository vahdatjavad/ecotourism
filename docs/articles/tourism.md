# Tourism data

The `ecotourism` package contains complementary tourism datasets at
quarterly tourism-region and monthly SA2 resolutions. This vignette
introduces the monthly stopover reason and activity datasets, their
code-name lookup tables, and the geographic metadata used to map them.

## 1 Data overview

`tourism_reason` contains monthly domestic overnight-trip estimates
classified by the reason for the stopover.

``` r

data("tourism_reason")
glimpse(tourism_reason)
```

    Rows: 196,044
    Columns: 6
    $ year         <int> 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 201…
    $ month        <ord> January, January, January, January, January, January, Jan…
    $ sa2_code_tra <int> 11009, 11009, 11014, 11014, 11015, 11015, 11016, 11016, 1…
    $ stop_reason  <int> 1, 2, 1, 2, 1, 2, 1, 3, 1, 2, 6, 8, 1, 1, 2, 3, 1, 1, 2, …
    $ trips        <dbl> 4.490612, 14.718867, 1.340082, 6.860708, 6.368905, 12.523…
    $ n_sample     <int> 2, 3, 1, 2, 3, 3, 12, 1, 10, 8, 2, 2, 2, 3, 2, 1, 1, 7, 1…

`tourism_activity` contains the corresponding estimates classified by
activity.

``` r

data("tourism_activity")
glimpse(tourism_activity)
```

    Rows: 320,188
    Columns: 6
    $ year          <int> 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 2014, 20…
    $ month         <ord> January, January, January, January, January, January, Ja…
    $ sa2_code_tra  <int> 11009, 11009, 11009, 11009, 11014, 11014, 11015, 11015, …
    $ stop_activity <int> 1, 3, 5, 6, 6, 7, 1, 2, 6, 1, 2, 3, 6, 1, 2, 3, 5, 6, 7,…
    $ trips         <dbl> 15.6321730, 2.1298693, 2.1298693, 19.2094791, 6.8607083,…
    $ n_sample      <int> 2, 2, 2, 5, 2, 1, 2, 2, 5, 10, 8, 2, 11, 13, 7, 1, 5, 19…

Both datasets cover 2014–2024. Trip estimates are expressed in
thousands, and `n_sample` gives the survey sample supporting each
estimate. Rows with zero `trips` or zero `n_sample` have been removed.

## 2 Add descriptive category names

The compact integer category fields can be decoded with
`tourism_reason_name` and `tourism_activity_name`.

``` r

data("tourism_reason_name")
data("tourism_activity_name")

tourism_reason_name
```

    # A tibble: 7 × 2
      stop_reason name
            <int> <chr>
    1           1 Holiday
    2           2 Visiting friends and relatives
    3           3 Business
    4           6 Other reason
    5           7 No other reason
    6           8 In transit
    7           9 Not stated/not asked          

``` r

tourism_activity_name
```

    # A tibble: 8 × 2
      stop_activity name
              <int> <chr>
    1             1 Outdoor / nature
    2             2 Active outdoor / sports
    3             3 Arts / heritage
    4             5 Local attractions / tourist activities
    5             6 Social activities
    6             7 None of these
    7             8 Not asked
    8             9 Other activities                      

Join the lookup table appropriate to the detailed dataset:

``` r

reason_named <- tourism_reason |>
  left_join(tourism_reason_name, by = "stop_reason")

activity_named <- tourism_activity |>
  left_join(tourism_activity_name, by = "stop_activity")

reason_named |>
  count(year, name, wt = trips, name = "trips_thousands") |>
  arrange(year, desc(trips_thousands)) |>
  head()
```

    # A tibble: 6 × 3
       year name                           trips_thousands
      <int> <chr>                                    <dbl>
    1  2014 Holiday                                 43487.
    2  2014 Visiting friends and relatives          31788.
    3  2014 Business                                18879.
    4  2014 Other reason                             5243.
    5  2014 In transit                               1061.
    6  2015 Holiday                                 44444.

## 3 Add tourism-region metadata

The detailed datasets share `sa2_code_tra` with `tourism_region`. The
packaged region table stores this identifier as character, so harmonise
the type before joining.

``` r

data("tourism_region")

region_lookup <- tourism_region |>
  mutate(sa2_code_tra = as.integer(sa2_code_tra)) |>
  distinct(sa2_code_tra, state, region, sa2, lon, lat, ws_id)

reason_with_region <- reason_named |>
  left_join(region_lookup, by = "sa2_code_tra")

reason_with_region |>
  select(year, month, state, region, sa2, name, trips, n_sample) |>
  head()
```

    # A tibble: 6 × 8
       year month   state           region          sa2         name  trips n_sample
      <int> <ord>   <chr>           <chr>           <chr>       <chr> <dbl>    <int>
    1  2014 January New South Wales Capital Country Queanbeyan  Holi…  4.49        2
    2  2014 January New South Wales Capital Country Queanbeyan  Visi… 14.7         3
    3  2014 January New South Wales Snowy Mountains Cooma       Holi…  1.34        1
    4  2014 January New South Wales Snowy Mountains Cooma       Visi…  6.86        2
    5  2014 January New South Wales Snowy Mountains Cooma Surr… Holi…  6.37        3
    6  2014 January New South Wales Snowy Mountains Cooma Surr… Visi… 12.5         3

The same `region_lookup` can be joined to `tourism_activity`. The
`ws_id` column can subsequently be joined to `weather_stations` when
weather context is needed.

## 4 SA2 polygons and representative points

`oz_sa2` provides simplified 2021 SA2 polygons for every TRA code
represented by the detailed tourism data. Its `lat` and `lon` columns
provide one representative interior point per SA2 when point geometry is
more convenient.

``` r

data("oz_sa2")
glimpse(oz_sa2)
```

    Rows: 2,350
    Columns: 4
    $ sa2_code_tra <int> 11007, 11008, 11009, 11010, 11012, 11013, 11014, 11015, 1…
    $ lat          <dbl> -35.51037, -35.37553, -35.35231, -35.36064, -35.37693, -3…
    $ lon          <dbl> 149.7535, 149.2337, 149.2253, 149.2515, 149.2015, 149.068…
    $ geometry     <MULTIPOLYGON [°]> MULTIPOLYGON (((149.7607 -3..., MULTIPOLYGON…

Join an SA2 summary directly to the polygon table for mapping:

``` r

reason_by_sa2 <- tourism_reason |>
  summarise(
    trips_thousands = sum(trips),
    .by = sa2_code_tra
  )

reason_map <- oz_sa2 |>
  left_join(reason_by_sa2, by = "sa2_code_tra")

reason_map |>
  select(sa2_code_tra, lat, lon, trips_thousands) |>
  head()
```

    Simple feature collection with 6 features and 4 fields
    Geometry type: MULTIPOLYGON
    Dimension:     XY
    Bounding box:  xmin: 148.3952 ymin: -37.26275 xmax: 150.2157 ymax: -34.99963
    Geodetic CRS:  GDA2020
    # A tibble: 6 × 5
      sa2_code_tra   lat   lon trips_thousands                              geometry
             <int> <dbl> <dbl>           <dbl>                    <MULTIPOLYGON [°]>
    1        11007 -35.5  150.          748.   (((149.7607 -35.08347, 149.7577 -35.…
    2        11008 -35.4  149.           19.2  (((149.2192 -35.3601, 149.2148 -35.3…
    3        11009 -35.4  149.         1120.   (((149.2315 -35.34224, 149.2179 -35.…
    4        11010 -35.4  149.            7.63 (((149.2316 -35.34221, 149.2359 -35.…
    5        11012 -35.4  149.           56.6  (((149.2065 -35.34586, 149.2045 -35.…
    6        11013 -36.9  149.          229.   (((148.422 -36.88885, 148.5236 -36.9…

## 5 Recover omitted zero rows

Use
[`tidyr::complete()`](https://tidyr.tidyverse.org/reference/complete.html)
to restore the full monthly panels; combinations absent from the
packaged data are assigned zero `trips` and `n_sample`.

``` r

all_sa2 <- union(tourism_reason$sa2_code_tra, tourism_activity$sa2_code_tra)
months <- factor(month.name, levels = month.name, ordered = TRUE)

tourism_reason_full <- tourism_reason |>
  tidyr::complete(year = 2014:2024, month = months, sa2_code_tra = all_sa2,
                  stop_reason = tourism_reason_name$stop_reason,
                  fill = list(trips = 0, n_sample = 0))

tourism_activity_full <- tourism_activity |>
  tidyr::complete(year = 2014:2024, month = months, sa2_code_tra = all_sa2,
                  stop_activity = tourism_activity_name$stop_activity,
                  fill = list(trips = 0, n_sample = 0))
```
