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
  "galah", "tidyverse", "lubridate", "geosphere", "sf",
  "rnaturalearth", "rnaturalearthdata", "knitr", "janitor",
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
obs_data <- function(taxa = "", start = 2014, end = 2024,
                     your_email = "") {
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
      year, month, day, eventDate, scientificName,
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
                     "year", "month", "day", "scientificName", "stateProvince")

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
      datetime = eventDate,
      weekday = lubridate::wday(eventDate, label = TRUE, abbr = FALSE),
      dayofyear = lubridate::yday(eventDate),
      scientificName = stringr::str_remove(scientificName, "\\s*\\([^\\)]+\\)"),
      obs_state = stateProvince
    ) %>%
    select(
      obs_lat, obs_lon, year, month, day,
      weekday, dayofyear, datetime,
      scientificName, obs_state
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



#' Load a data object by organism name from the data folder
#'
#' @param organism Character. Base name of the organism (e.g., "glowworms").
#'
#' @return The loaded data object (e.g., `glowworms`).
#' @export
myload <- function(organism) {
  object_name <- organism
  file_path <- file.path("../data", paste0(object_name, ".rda"))

  # Load into temporary environment
  temp_env <- new.env()
  load(file_path, envir = temp_env)

  # Return the object
  get(object_name, envir = temp_env)
}



#' Count occurrences by scientific name and state, and reshape the result
#'
#' @param data A data frame.
#' @param Sci_Name Unquoted column name for scientific names.
#' @param state Unquoted column name for states or regions.
#' @param f filter the count to greater than this number
#'
#' @return A pivoted data frame with counts and totals.
#' @export
my_count <- function(data, Sci_Name, state, f=0) {
  data |>
    count({{ Sci_Name }}, {{ state }}) |>
    filter(n > f ) |>
    tidyr::pivot_wider(
      names_from = {{ state }},
      values_from = n,
      values_fill = 0
    ) |>
    janitor::adorn_totals(where = c("row", "col"))
}


#' Plot faceted map of observations in Australia
#'
#' @param data A data frame with observation coordinates.
#' @param aus_map A spatial (sf) object of Australia map.
#' @param color_by Unquoted column name to color points by (e.g., `scientificName`, `obs_state`, `stn_state`).
#' @param facet_by Optional unquoted column name to facet by. Default is NULL (no faceting).
#'
#' @return A ggplot object.
#' @export
plot_map1 <- function(data, color_by = scientificName, facet_by = NULL, stn = FALSE) {
  # Load Australia base map (sf object)
  aus_map <- ne_states(country = "Australia", returnclass = "sf")

  p <- ggplot() +
    geom_sf(data = aus_map, fill = "gray95", color = "gray50") +
    geom_point(data = data, aes(x = obs_lon, y = obs_lat, color = {{ color_by }}),
               alpha = 0.6, size = 1.5) +
    coord_sf(xlim = c(115, 155), ylim = c(-45, -10)) +
    theme_minimal() +
    theme(
      strip.text = element_text(face = "bold"),
      panel.grid = element_blank()
    ) +
    labs(
      title = paste("Distribution of", organism_title, "Occurrence Sightings in Australia"),
      x = "Longitude",
      y = "Latitude",
      color = deparse(substitute(color_by))
    )

  # Add facet if requested
  if (!is.null(facet_by)) {
    p <- p + facet_wrap(vars({{ facet_by }}), scales = "free_y")
  }

  if (stn) {
    p <- p + geom_point(data = df, aes(x = stn_lon, y = stn_lat), shape = 2, alpha = 0.6, size = 1.5)
  }

  return(p)
}


#' Stacked bar plot of scientific names by weekday
#'
#' @param organism A data frame with `weekday` and `scientificName` columns.
#' @param organism_title Character. Title for the plot.
#'
#' @return A ggplot object.
#' @export
plot_bar_week <- function(organism) {
  week_order <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

  organism |>
    tidyr::drop_na(weekday, scientificName) |>
    ggplot(aes(x = factor(weekday, levels = week_order), fill = scientificName)) +
    geom_bar() +
    labs(
      title = paste("Weekday Distribution of", organism_title, "Sightings"),
      x = "Weekday", y = "Number of Records",
      fill = "Scientific Name"
    ) +
    theme_bw() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      legend.title = element_text(face = "bold")
    )
}


#' Stacked bar plot of scientific names by month
#'
#' @param organism A data frame with `month` and `scientificName` columns.
#' @param organism_title Character. Title for the plot.
#'
#' @return A ggplot stacked bar chart.
#' @export
plot_bar_month <- function(organism) {
  organism |>
    tidyr::drop_na(month, scientificName) |>
    dplyr::mutate(month = lubridate::month(month, label = TRUE, abbr = FALSE)) |>
    ggplot(aes(x = factor(month, levels = month.name), fill = scientificName)) +
    geom_bar() +
    labs(
      title = paste("Monthly Distribution of", organism_title, "Sightings"),
      x = "Month", y = "Number of Records",
      fill = "Scientific Name"
    ) +
    theme_bw() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      legend.title = element_text(face = "bold")
    )
}


#' Stacked bar plot of scientific names by year
#'
#' @param organism A data frame with `year` and `scientificName` columns.
#' @param organism_title Character. Title for the plot.
#'
#' @return A ggplot stacked bar chart.
#' @export
plot_bar_year <- function(organism) {
  organism |>
    tidyr::drop_na(year, scientificName) |>
    ggplot(aes(x = factor(year), fill = scientificName)) +
    geom_bar() +
    labs(
      title = paste("Yearly Distribution of", organism_title, "Sightings"),
      x = "Year", y = "Number of Records",
      fill = "Scientific Name"
    ) +
    theme_bw() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      legend.title = element_text(face = "bold")
    )
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
    weather_stations$stnid[which.min(dists)]
  })

  # Add nearest station info
  org_data$weather_station_id <- nearest_station_ids

  org_with_ws <- dplyr::left_join(
    org_data,
    weather_stations,
    by = c("weather_station_id" = "stnid")
  )

  # Create object name dynamically
  object_name <- paste0(organism_name, "_ws")

  # Assign the data to the named object in the global environment
  assign(object_name, org_with_ws, envir = .GlobalEnv)

  # Save with a new name
  save_path <- file.path("../data", paste0(organism_name, "_ws.rda"))
  save(list = object_name, file = save_path)

  cat("Nearest weather stations attached and saved as:", basename(save_path), "\n")
  invisible(org_with_ws)
}






parse_address <- function(addr) {              # helper to extract city / state
  tokens <- str_split(addr, ",")[[1]]          # split at commas
  tokens <- str_trim(tokens)                   # trim spaces
  tokens <- tokens[!(tokens == "Australia")]   # drop country
  tokens <- tokens[!str_detect(tokens, "^[0-9]+$")]  # drop pure numerics (postcodes)

  # State  = last token remaining
  # City   = first token remaining
  state <- tokens[length(tokens)]
  city  <- tokens[1]

  tibble(stn_city = city, state = stn_state)
}




myload_ws <- function(organism_name) {
  # Construct file path
  file_path <- file.path("../data", paste0(organism_name, "_ws.rda"))

  # Load into a temporary environment
  temp_env <- new.env()
  loaded_names <- load(file_path, envir = temp_env)

  # Assume only one object was loaded — return it
  if (length(loaded_names) != 1) {
    stop("Expected one object in file, found: ", paste(loaded_names, collapse = ", "))
  }

  temp_env[[loaded_names[1]]]
}







summarize_state_frequencies <- function(organism_name) {
  # Load the organism data from file
  file_path <- file.path("../data", paste0(organism_name, "_ws.rda"))
  temp_env <- new.env()
  loaded_names <- load(file_path, envir = temp_env)

  # Get the loaded object (assume only one)
  if (length(loaded_names) != 1) {
    stop("Expected one object in file, found: ", paste(loaded_names, collapse = ", "))
  }

  data <- temp_env[[loaded_names[1]]]

  # Check that both state columns exist
  if (!all(c("obs_state", "stn_state") %in% names(data))) {
    stop("Required columns 'obs_state' and/or 'stn_state' are missing.")
  }

  # Frequency tables
  obs_freq <- table(data$obs_state)
  stn_freq <- table(data$stn_state)

  # Merge into a single dataframe
  obs_df <- as.data.frame(obs_freq)
  stn_df <- as.data.frame(stn_freq)

  colnames(obs_df) <- c("State", "Observed")
  colnames(stn_df) <- c("State", "WeatherStation")

  # Full join to combine both
  summary_df <- merge(obs_df, stn_df, by = "State", all = TRUE)

  # Replace NAs with 0 for consistency
  summary_df[is.na(summary_df)] <- 0

  # Optional: sort by highest observed or weather station count
  summary_df <- summary_df[order(-summary_df$Observed), ]

  return(summary_df)
}




plot_monthly_occurrences_by_state <- function(organism_name, mss = NULL) {
  # Load organism data using your custom loader
  data <- myload_ws(organism_name)

  if (!is.null(mss)){
    data <- myload_ws(organism_name) |> filter(scientificName %in% mss)
  }
  # Ensure necessary columns exist
  if (!all(c("datetime", "obs_state", "scientificName") %in% names(data))) {
    stop("The dataset must contain 'datetime', 'obs_state', and 'scientificName' columns.")
  }

  # Add month columns
  data$month <- format(data$datetime, "%B")
  data$month_num <- as.numeric(format(data$datetime, "%m"))
  data$month <- factor(data$month, levels = month.name)

  # Create the stacked bar plot
  p <- ggplot(data, aes(x = month, fill = scientificName)) +
    geom_bar() +
    labs(
      title = paste("Monthly Distribution of", organism_title, "Occurrences by State"),
      x = "Month", y = "Number of Records", fill = "Scientific Name"
    ) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    facet_wrap(. ~ obs_state, scales = "free_y") +
    scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

  print(p)
}





plot_weekly_occurrences_by_state <- function(organism_name, mss = NULL) {
  # Load data
  data <- myload_ws(organism_name)

  if (!is.null(mss)){
    data <- myload_ws(organism_name) |> filter(scientificName %in% mss)
  }

  # Check for necessary columns
  if (!all(c("datetime", "obs_state") %in% names(data))) {
    stop("The dataset must contain 'datetime' and 'obs_state' columns.")
  }

  # Prepare weekly data
  data <- data %>%
    mutate(
      date = as.Date(datetime),
      week_start = floor_date(date, "week")
    )

  weekly_counts <- data %>%
    count(week_start, obs_state)

  # Plot
  p <- ggplot(weekly_counts, aes(x = week_start, y = n)) +
    geom_line(color = "#2ca02c") +
    geom_smooth(method = "loess", se = FALSE, color = "#d62728") +
    facet_wrap(~ obs_state, scales = "free_y") +
    labs(
      title = paste("Weekly Occurrence Patterns of", organism_title, "with Trend Lines"),
      x = "Week Starting", y = "Observations"
    ) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

  print(p)
}


plot_seasonal_occurrence_polar <- function(organism_name, mss = NULL) {

  # Load the organism data
  data <- myload_ws(organism_name)

  if (!is.null(mss)){
    data <- myload_ws(organism_name) |> filter(scientificName %in% mss)
  }

  # Check for necessary columns
  if (!all(c("datetime", "obs_state") %in% names(data))) {
    stop("The dataset must contain 'datetime' and 'obs_state' columns.")
  }

  # Add date, month name, and numeric month
  data <- data %>%
    mutate(
      date = as.Date(datetime),
      month = format(date, "%B"),
      month_num = as.numeric(format(date, "%m")),
      month = factor(month, levels = month.name)  # Ensure correct month order
    )

  # Compute monthly percentages by state
  state_monthly <- data %>%
    group_by(obs_state, month) %>%
    summarize(count = n(), .groups = "drop") %>%
    group_by(obs_state) %>%
    mutate(percent = 100 * count / sum(count))

  # Plot using polar coordinates
  p <- ggplot(state_monthly, aes(x = month, y = percent, color = obs_state, group = obs_state)) +
    geom_line(linewidth = 1.5) +
    coord_polar() +
    scale_x_discrete(limits = month.name) +
    labs(
      title = paste("Seasonal Patterns of", organism_title, "Occurrences by State"),
      x = NULL, y = "Percentage of Occurrences",
      color = "State"
    ) +
    theme_minimal()

  print(p)
}



plot_monthly_occurrence_map <- function(organism_name, mss = NULL) {

  # Load data
  data <- myload_ws(organism_name)

  if (!is.null(mss)){
    data <- myload_ws(organism_name) |> filter(scientificName %in% mss)
  }

  # Check for required columns
  required_cols <- c("obs_lat", "obs_lon", "stn_lat", "stn_lon", "datetime", "scientificName")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Prepare data
  data <- data %>%
    mutate(
      date = as.Date(datetime),
      month = format(date, "%B"),
      month = factor(month, levels = month.name)
    ) %>%
    filter(!is.na(obs_lat), !is.na(obs_lon), !is.na(month))

  # Load Australia shapefile
  aus_map <- ne_states(country = "Australia", returnclass = "sf")

  # Plot
  p <- ggplot() +
    geom_sf(data = aus_map, fill = "gray95", color = "gray50") +
    geom_point(
      data = data,
      aes(x = obs_lon, y = obs_lat, color = scientificName),
      alpha = 0.6, size = 1.5
    ) +
    geom_point(
      data = data,
      aes(x = stn_lon, y = stn_lat),
      shape = 2, alpha = 0.6, size = 1.5
    ) +
    coord_sf(xlim = c(110, 155), ylim = c(-45, -10)) +
    facet_wrap(~ month) +
    theme_minimal() +
    theme(
      strip.text = element_text(face = "bold"),
      panel.grid = element_blank()
    ) +
    labs(
      title = paste("Distribution of", organism_title, "Sightings by Month in Australia"),
      x = "Longitude",
      y = "Latitude",
      color = "Species"
    )

  print(p)
}






plot_monthly_occurrence_map_by_state <- function(organism_name, mss = NULL) {

  # Load organism data
  data <- myload_ws(organism_name)

  if (!is.null(mss)){
    data <- myload_ws(organism_name) |> filter(scientificName %in% mss)
  }

  # Check required columns
  required_cols <- c("datetime", "obs_lat", "obs_lon", "stn_lat", "stn_lon", "obs_state")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Prepare data
  data <- data %>%
    mutate(
      date = as.Date(datetime),
      month = format(date, "%B"),
      month = factor(month, levels = month.name)
    ) %>%
    filter(!is.na(obs_lat), !is.na(obs_lon), !is.na(month))

  # Load base map for Australia
  aus_map <- ne_states(country = "Australia", returnclass = "sf")

  # Create faceted map
  p <- ggplot() +
    geom_sf(data = aus_map, fill = "gray95", color = "gray50") +
    geom_point(
      data = data,
      aes(x = obs_lon, y = obs_lat, color = obs_state),
      alpha = 0.6, size = 1.5
    ) +
    geom_point(
      data = data,
      aes(x = stn_lon, y = stn_lat),
      shape = 2, alpha = 0.6, size = 1.5
    ) +
    coord_sf(xlim = c(110, 155), ylim = c(-45, -10)) +
    facet_wrap(~ month) +
    theme_minimal() +
    theme(
      strip.text = element_text(face = "bold"),
      panel.grid = element_blank()
    ) +
    labs(
      title = paste("Distribution of", organism_title, "Sightings in Australia by State and Month"),
      x = "Longitude",
      y = "Latitude",
      color = "Observed State"
    )

  print(p)
}





plot_monthly_distribution_map <- function(organism_name, mss = NULL) {

  # Load data
  data <- myload_ws(organism_name)

  if (!is.null(mss)){
    data <- myload_ws(organism_name) |> filter(scientificName %in% mss)
  }

  # Check for required columns
  required_cols <- c("datetime", "obs_lat", "obs_lon", "stn_lat", "stn_lon", "obs_state")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Prepare data
  data <- data %>%
    mutate(
      date = as.Date(datetime),
      month = format(date, "%B"),
      month = factor(month, levels = month.name)
    ) %>%
    filter(!is.na(obs_lat), !is.na(obs_lon), !is.na(month))

  # Load Australia base map
  aus_map <- ne_states(country = "Australia", returnclass = "sf")

  # Create the faceted map
  p <- ggplot() +
    geom_sf(data = aus_map, fill = "gray95", color = "gray50") +
    geom_point(
      data = data,
      aes(x = obs_lon, y = obs_lat, color = obs_state),
      alpha = 0.6, size = 1.5
    ) +
    geom_point(
      data = data,
      aes(x = stn_lon, y = stn_lat),
      shape = 2, alpha = 0.6, size = 1.5
    ) +
    coord_sf(xlim = c(110, 155), ylim = c(-45, -10)) +
    facet_wrap(~ month, ncol = 4) +
    theme_minimal() +
    theme(
      strip.text = element_text(face = "bold"),
      panel.grid = element_blank()
    ) +
    labs(
      title = paste("Monthly Distribution of", organism_title, "Sightings in Australia"),
      x = "Longitude",
      y = "Latitude",
      color = "State"
    )

  print(p)
}

