# Function to ensure required packages are installed and loaded
ensure_packages <- function(pkgs) {
  for (pkg in pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg)
    }
    library(pkg, character.only = TRUE)
  }
}

required_pkgs <- c(
  "galah", "dplyr", "lubridate", "geosphere", "sf",
  "knitr", "janitor",
  "GSODR", "tidygeocoder"
)

# Install and load all packages
ensure_packages(required_pkgs)




#' Retrieve occurrence data from ALA for a given taxon and time range
#'
#' @param taxa Character. Taxon name to search (e.g., "Arachnocampa").
#' @param start Integer. Start year for filtering occurrences.
#' @param end Integer. End year for filtering occurrences.
#' @param email Character. Email address for ALA access. Default is NULL.
#'
#' @return A data frame of occurrence records.
#' @export
obs_data <- function(taxa = "", start = 2014, end = 2024, your_email) {
  # Input validation
  if (taxa == "") stop("Please provide a valid taxon name.")
  if (!is.numeric(start) || !is.numeric(end)) stop("Start and end must be numeric.")
  if (start > end) stop("Start year must be less than or equal to end year.")

  # Set up ALA access if email is provided
  if (!is.null(email)) {
    galah_config(email = your_email)
  }

  # Search for the taxon
  taxon_info <- search_taxa(taxa)

  # Retrieve occurrence data
  galah_call() |>
    galah_identify(taxon_info) |>
    galah_filter(year >= start, year <= end) |>
    galah_select(
      decimalLatitude, decimalLongitude,
      year, month, day, eventDate, basisOfRecord,scientificName,
      stateProvince
    ) |>
    atlas_occurrences()
}



#' Clean and standardize ALA occurrence data
#'
#' @param mydata A data frame returned by `obs_data()`.
#'
#' @return A cleaned data frame with selected and renamed columns.
#' @export
polished_data <- function(mydata) {
  required_cols <- c("decimalLatitude", "decimalLongitude", "eventDate",
                     "year", "month", "day", "basisOfRecord","scientificName", "stateProvince")

  # Check if all required columns exist
  missing_cols <- setdiff(required_cols, names(mydata))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  mydata %>%
    filter(
      !is.na(decimalLatitude),
      !is.na(decimalLongitude),
      !is.na(eventDate)
    ) %>%
    mutate(
      obs_lat = decimalLatitude,
      obs_lon = decimalLongitude,
      date = date(eventDate),
      time = format(eventDate, "%H:%M:%S"),
      hour = hour(eventDate),
      weekday = lubridate::wday(eventDate, label = TRUE, abbr = FALSE,
                                week_start = getOption("lubridate.week.start", 1)),
      dayofyear = lubridate::yday(eventDate),
      sci_name = stringr::str_remove(scientificName, "\\s*\\([^\\)]+\\)"),
      record_type = basisOfRecord,
      obs_state = stateProvince
    ) %>%
    select(
      obs_lat, obs_lon, date, time, year, month, day, hour,
      weekday, dayofyear, sci_name, record_type, obs_state
    )
}





#' Save raw data with a dynamic name
#'
#' Saves a data frame as an `.rda` file using a name based on the organism.
#'
#' @param organism Character. Base name for the saved object (e.g., "glowworms").
#' @param raw_data Data frame to save.
#'
#' @return Invisibly returns the file path.
#' @export
mysave_raw <- function(organism_name, raw_data) {
  # Create object name dynamically
  object_name <- paste0(organism_name, "_raw")

  # Assign the data to the named object in the global environment
  assign(object_name, raw_data, envir = .GlobalEnv)

  # Save the object to a file
  save_path <- file.path("../data-raw", paste0(object_name, ".rda"))
  save(list = object_name, file = save_path)

  # Optionally return the path for confirmation/logging
  invisible(save_path)
}



#' Save data with a dynamic name
#'
#' Saves a data frame as an `.rda` file using a name based on the organism.
#'
#' @param organism Character. Base name for the saved object (e.g., "glowworms").
#' @param data Data frame to save.
#'
#' @return Invisibly returns the file path.
#' @export
mysave <- function(organism_name, data) {
  # Create object name dynamically
  object_name <- paste0(organism_name)

  # Assign the data to the named object in the global environment
  assign(object_name, data, envir = .GlobalEnv)

  # Save the object to a file
  save_path <- file.path("../data", paste0(object_name, ".rda"))
  save(list = object_name, file = save_path)

  # Optionally return the path for confirmation/logging
  invisible(save_path)
}






#' Load a raw data object by organism name
#'
#' @param organism Character. Base name of the organism (e.g., "glowworms").
#'
#' @return The loaded data frame (e.g., `glowworms_raw`).
#' @export
myload_raw <- function(organism) {
  # Construct object name and file path
  object_name <- paste0(organism, "_raw")
  file_path <- file.path("../data-raw", paste0(object_name, ".rda"))

  # Load the object into a temporary environment
  temp_env <- new.env()
  load(file_path, envir = temp_env)

  # Return the object from the temp environment
  get(object_name, envir = temp_env)
}



#' Attach nearest weather station to an organism dataset
#'
#' Loads the organism data and weather station data, calculates the nearest station
#' for each occurrence, joins station metadata, and saves the result.
#'
#' @param organism Character. Name of the organism dataset.
#'
#' @return Invisibly returns the joined dataset.
#' @export
attach_nearest_station <- function(organism_name = "") {
  # Construct file paths
  org_path <- file.path("../data", paste0(organism_name, ".rda"))
  stations_path <- file.path("../data", "weather_stations.rda")

  # Load into a temporary environment
  temp_env <- new.env()
  load(org_path, envir = temp_env)
  load(stations_path, envir = temp_env)

  # Extract data
  org_data <- get(organism_name, envir = temp_env)
  weather_stations <- get("weather_stations", envir = temp_env)

  # Compute nearest weather station for each observation
  nearest_station_ids <- sapply(1:nrow(org_data), function(i) {
    dists <- geosphere::distHaversine(
      cbind(weather_stations$stn_lon, weather_stations$stn_lat),
      c(org_data$obs_lon[i], org_data$obs_lat[i])
    )
    weather_stations$ws_id[which.min(dists)]
  })

  # Add nearest station info
  org_data$ws_id <- nearest_station_ids

  # Create object name dynamically
  object_name <- paste0(organism_name)

  # Assign the data to the named object in the global environment
  assign(object_name, org_data, envir = .GlobalEnv)

  # Save with a new name
  save_path <- file.path("../data", paste0(organism_name, ".rda"))
  save(list = object_name, file = save_path)

  cat("Nearest weather stations attached and saved as:", basename(save_path), "\n")
  invisible(org_data)
}

