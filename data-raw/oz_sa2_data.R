# Build the oz_sa2 package dataset from official ABS 2021 SA2 boundaries.
#
# Run from the package root:
#   Rscript data-raw/oz_sa2_data.R
#
# To reuse an existing download:
#   ABS_SA2_ZIP=/path/to/SA2_2021_AUST_SHP_GDA2020.zip \
#     Rscript data-raw/oz_sa2_data.R

library(dplyr)
library(fs)
library(rmapshaper)
library(sf)
library(stringr)

if (!file_exists("DESCRIPTION") || !dir_exists("data-raw")) {
  stop("Run this script from the ecotourism package root.")
}

source_url <- paste0(
  "https://www.abs.gov.au/statistics/standards/",
  "australian-statistical-geography-standard-asgs/",
  "edition-3-july-2021-june-2026/access-and-downloads/",
  "digital-boundary-files/SA2_2021_AUST_SHP_GDA2020.zip"
)

supplied_archive <- Sys.getenv("ABS_SA2_ZIP", unset = "")
downloaded_archive <- supplied_archive == ""
archive <- if (downloaded_archive) {
  tempfile(fileext = ".zip")
} else {
  path_abs(supplied_archive)
}

if (downloaded_archive) {
  message("Downloading ABS SA2 boundaries...")
  download.file(source_url, archive, mode = "wb", quiet = FALSE)
} else if (!file_exists(archive)) {
  stop("ABS_SA2_ZIP does not exist: ", archive)
}

extract_dir <- tempfile("abs-sa2-")
dir_create(extract_dir)
on.exit(dir_delete(extract_dir), add = TRUE)

unzip(archive, exdir = extract_dir)

shape_file <- dir_ls(
  extract_dir,
  regexp = "SA2_2021_AUST_GDA2020\\.shp$",
  recurse = TRUE
)

if (length(shape_file) != 1) {
  stop("Expected one ABS SA2 shapefile; found ", length(shape_file), ".")
}

message("Reading ABS boundaries...")
abs_sa2 <- read_sf(shape_file)

required_abs_columns <- c("SA2_CODE21", "SA2_NAME21", "STE_NAME21")
missing_abs_columns <- setdiff(required_abs_columns, names(abs_sa2))

if (length(missing_abs_columns) > 0) {
  stop(
    "ABS shapefile is missing required columns: ",
    str_c(missing_abs_columns, collapse = ", ")
  )
}

# TRA exports use five-digit codes rather than the native nine-digit ABS
# SA2_CODE21. Match the 2021 ABS polygons to the package's TRA lookup using
# state and SA2 names, retaining the genuine TRA code for downstream joins.
normalise_name <- function(value) {
  value |>
    str_to_lower() |>
    str_squish() |>
    str_replace_all("&", "and")
}

state_names <- c(
  ACT = "Australian Capital Territory",
  NSW = "New South Wales",
  NT = "Northern Territory",
  QLD = "Queensland",
  SA = "South Australia",
  TAS = "Tasmania",
  VIC = "Victoria",
  WA = "Western Australia"
)

tra_lookup <- readRDS("data-raw/tourism/tourism_region.rds") |>
  distinct(sa2_code_tra, state, sa2) |>
  filter(if_all(c(sa2_code_tra, state, sa2), ~ !is.na(.x))) |>
  mutate(
    state = coalesce(unname(state_names[state]), state),
    # TRA assigns the external territories to mainland state groups in its
    # export metadata; ABS groups them under "Other Territories".
    state = if_else(
      str_starts(sa2_code_tra, "91"),
      "Other Territories",
      state
    ),
    match_key = str_c(
      normalise_name(state),
      normalise_name(sa2),
      sep = "|"
    )
  ) |>
  select(sa2_code_tra, match_key)

abs_lookup <- abs_sa2 |>
  st_drop_geometry() |>
  transmute(
    SA2_CODE21,
    match_key = str_c(
      normalise_name(STE_NAME21),
      normalise_name(SA2_NAME21),
      sep = "|"
    )
  )

if (anyDuplicated(tra_lookup$match_key) > 0) {
  stop("The TRA lookup contains duplicate state-and-SA2 match keys.")
}

if (anyDuplicated(abs_lookup$match_key) > 0) {
  stop("The ABS boundaries contain duplicate state-and-SA2 match keys.")
}

code_lookup <- tra_lookup |>
  left_join(abs_lookup, by = "match_key", relationship = "one-to-one")

unmatched_tra <- code_lookup |>
  filter(is.na(SA2_CODE21))

if (nrow(unmatched_tra) > 0) {
  stop(
    nrow(unmatched_tra),
    " TRA SA2 codes could not be matched to ABS 2021 boundaries."
  )
}

sa2_full <- abs_sa2 |>
  inner_join(
    code_lookup |> select(sa2_code_tra, SA2_CODE21),
    by = "SA2_CODE21",
    relationship = "one-to-one"
  ) |>
  select(sa2_code_tra, geometry) |>
  mutate(sa2_code_tra = as.integer(sa2_code_tra)) |>
  arrange(sa2_code_tra)

# Calculate representative interior points from the full-resolution geometry.
# Australian Albers (EPSG:3577) provides an appropriate projected CRS for this
# spatial operation; coordinates are returned in GDA2020 longitude/latitude.
sa2_centres <- sa2_full |>
  st_geometry() |>
  st_transform(3577) |>
  st_point_on_surface() |>
  st_transform(7844) |>
  st_coordinates()

message("Simplifying polygon geometry with rmapshaper...")
oz_sa2 <- sa2_full |>
  ms_simplify(
    keep = 0.05,
    keep_shapes = TRUE,
    snap = TRUE
  ) |>
  st_make_valid() |>
  st_transform(7844) |>
  mutate(
    lat = sa2_centres[, "Y"],
    lon = sa2_centres[, "X"]
  ) |>
  select(sa2_code_tra, lat, lon, geometry)

if (anyDuplicated(oz_sa2$sa2_code_tra) > 0) {
  stop("oz_sa2 contains duplicate sa2_code_tra values.")
}

if (anyNA(oz_sa2$lat) || anyNA(oz_sa2$lon)) {
  stop("oz_sa2 contains missing representative coordinates.")
}

if (!all(st_is_valid(oz_sa2))) {
  stop("oz_sa2 contains invalid polygon geometry.")
}

save(
  oz_sa2,
  file = "data/oz_sa2.rda",
  compress = "xz"
)

message(
  "Saved data/oz_sa2.rda: ",
  nrow(oz_sa2),
  " SA2 polygons; ",
  format(object.size(oz_sa2), units = "auto")
)
