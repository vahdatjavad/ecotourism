
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ecotourism <img src="man/figures/logo.png" alt="ecotourism hex logo" align="right" width="120" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/vahdatjavad/ecotourism/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/vahdatjavad/ecotourism/actions/workflows/R-CMD-check.yaml)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
<!-- badges: end -->

The goal of **ecotourism** is to provide clean, ready-to-use datasets
for example analyses in teaching, demos, and reproducible workflows.  
It currently includes wildlife (e.g., cuttlefish) occurrence records,
tourism counts by region, and local weather for matching locations.

## Website

👉 Documentation site: **<https://vahdatjavad.github.io/ecotourism/>**

## Installation

Install the development version from GitHub:

``` r
# install.packages("pak")
pak::pak("vahdatjavad/ecotourism")
```

If you prefer `remotes`:

``` r
# install.packages("remotes")
remotes::install_github("vahdatjavad/ecotourism")
```

## What’s inside?

List all available datasets and their short titles:

| Object                | Title                                           |
|:----------------------|:------------------------------------------------|
| glowworms             | Glowworms Occurrence Data (2014–2024)           |
| gouldian_finch        | Gouldian Finch Occurrence Data (2014–2024)      |
| manta_rays            | Manta Ray Occurrence Data (2014–2024)           |
| orchids               | Orchid Occurrence Data (2014–2024)              |
| oz_sa2                | Australian Statistical Area Level 2 Boundaries  |
| top_stations          | Top Weather Stations for Each Organism          |
| tourism_activity      | Monthly Tourism Trips by Stopover Activity      |
| tourism_activity_name | Tourism Stopover Activity Names                 |
| tourism_reason        | Monthly Tourism Trips by Stopover Reason        |
| tourism_reason_name   | Tourism Stopover Reason Names                   |
| tourism_region        | Tourism Regions and Nearest Weather Stations    |
| weather               | Daily Weather Data for Top Stations (2014–2024) |
| weather_stations      | Australian Weather Station Metadata             |

This is the relational dataset in this package:

<img src="man/figures/datasets.png" alt="ecotourism dataset schema" width="500"/>

To see documentation for any dataset, use:

``` r
?ecotourism::DATASET_NAME
```

## Teaching and assessment resources

Two companion resources make it easier to use these datasets in
teaching:

- [**ecosanctuary**](https://vahdatjavad.github.io/ecosanctuary/) is an
  R package for validating, selecting, and building reusable Quarto or R
  Markdown questions. It can produce Moodle XML, interactive student
  practice quizzes, teacher answer keys with worked solutions, printable
  PDFs, and a record of the selected questions.
- The [**GSoC 2026 ecotourism question
  bank**](https://github.com/vahdatjavad/GSoC2026-questions) is a
  ready-to-use collection of 45 R questions based on the datasets in
  this package. It contains 15 easy, 15 medium, and 15 hard questions
  that cover data exploration, transformation, visualisation, joins,
  functions, iteration, and multi-dataset analysis.

The question bank provides the teaching content, while `ecosanctuary`
provides the tools that validate, select, and render that content.
Lecturers can use the complete bank or select questions by ID, topic,
and difficulty to create reproducible quizzes and teaching materials.

## Example

This is a minimal usage sketch. Replace `DATASET_NAME` with one from the
table above.

``` r
library(ecotourism)

# List datasets included in the package
utils::data(package = "ecotourism")

# Example workflow (replace DATASET_NAME with a real object from the list)
# data("DATASET_NAME", package = "ecotourism")
# head(DATASET_NAME)
# str(DATASET_NAME)

# Tip: quick summaries if dplyr is available:
# if (requireNamespace("dplyr", quietly = TRUE)) {
#   dplyr::glimpse(DATASET_NAME)
# }
```

## Getting help

- Open an issue with a minimal reproducible example:
  <https://github.com/vahdatjavad/ecotourism/issues>
- Check the function/dataset help pages (e.g.,
  `?ecotourism::DATASET_NAME`).

## Contributing

Pull requests are welcome! If you’re unsure where to start, open an
issue first to discuss changes.

## Citation

If you use **ecotourism** in teaching, demos, or research, please cite
it:

``` r
citation("ecotourism")
```
