#Function to ensure required packages are installed and loaded
ensure_packages <- function(pkgs) {
  for (pkg in pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg)
    }
    library(pkg, character.only = TRUE)
  }
}

required_pkgs <- c(
  "dplyr", "tidyr", "ggplot2", "lubridate", "sf",
  "rnaturalearth", "rnaturalearthdata", "knitr"
)

ensure_packages(required_pkgs)


if(!requireNamespace("rnaturalearthhires", quietly = TRUE)){
  install.packages(
    "rnaturalearthhires",
    repos = "https://ropensci.r-universe.dev",
    type = "source"
  )}
# # Install and load all packages
# for (i in required_pkgs){
#   library(i, character.only = TRUE)
# }





#' Plot faceted map of observations in Australia
#'
#' @param data A data frame with observation coordinates.
#' @param aus_map A spatial (sf) object of Australia map.
#' @param color_by Unquoted column name to color points by (e.g., `sci_name`, `obs_state`, `stn_state`).
#' @param facet_by Optional unquoted column name to facet by. Default is NULL (no faceting).
#'
#' @return A ggplot object.
#' @export
plot_map1 <- function(data, color_by = "sci_name", facet_by = NULL,
                     stn = FALSE, stn_data = NULL,
                     legend = TRUE) {


  # Australia basemap
  aus_map <- rnaturalearth::ne_states(country = "Australia", returnclass = "sf")

  p <- ggplot2::ggplot() +
    geom_sf(data = aus_map, fill = "gray95", color = "gray50") +
    geom_point(data = data,
               aes(x = obs_lon, y = obs_lat, color = color_by),
               alpha = 0.6, size = 1.5) +
    coord_sf(xlim = c(115, 155), ylim = c(-45, -10)) +
    theme_minimal() +
    theme(
      strip.text = element_text(face = "bold"),
      panel.grid = element_blank()
    ) +
    labs(
      title = paste("Distribution of Occurrence Sightings in Australia"),
      x = "Longitude",
      y = "Latitude",
      color = color_by
    )

  # Facet option
  if (!is.null(facet_by)) {
    p <- p + facet_wrap(vars(!!facet_by), scales = "free_y")
  }

  # Weather stations
  if (stn && !is.null(stn_data)) {
    p <- p + geom_point(data = stn_data,
                        aes(x = stn_lon, y = stn_lat),
                        shape = 2, alpha = 0.6, size = 1.5)
  }

  # Legend toggle
  if (!legend) {
    p <- p + theme(legend.position = "none")
  }

  return(p)
}


#' Stacked bar plot of scientific names by weekday
#'
#' @param organism A data frame with `weekday` and `sci_name` columns.
#' @param organism_title Character. Title for the plot.
#'
#' @return A ggplot object.
#' @export
plot_bar_week <- function(organism, legend = NULL) {
  week_order <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

  data <- organism |>
    tidyr::drop_na(weekday, sci_name)

    p <- ggplot(data, aes(x = factor(weekday, levels = week_order), fill = sci_name)) +
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
  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }
  return(p)
}


plot_bar_week_100 <- function(organism, organism_title = "Organism", legend = NULL) {
  week_order <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")

  p <- organism %>%
    tidyr::drop_na(weekday, sci_name) %>%
     ggplot(aes(x = factor(weekday, levels = week_order), fill = sci_name)) +
    geom_bar(position = "fill") +
    scale_y_continuous(labels = scales::percent_format()) +
    labs(
      title = paste("Weekday Distribution of", organism_title, "Sightings"),
      x = "Weekday",
      y = "Proportion of Records",
      fill = "Scientific Name"
    ) +
    theme_bw() +
    theme(
      axis.text.x = element_text(angle = 45, hjust = 1),
      legend.title = element_text(face = "bold")
    )
  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }
  return(p)
}

#' Stacked bar plot of scientific names by month
#'
#' @param organism A data frame with `month` and `sci_name` columns.
#' @param organism_title Character. Title for the plot.
#'
#' @return A ggplot stacked bar chart.
#' @export
plot_bar_month <- function(organism, legend = NULL) {
  p <- organism |>
    tidyr::drop_na(month, sci_name) |>
     dplyr::mutate(month = lubridate::month(month, label = TRUE, abbr = FALSE)) |>
    ggplot(aes(x = factor(month, levels = month.name), fill = sci_name)) +
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
    if (!is.null(legend)){
      p <- p + theme(legend.position = "none")
    }
    return(p)
}


#' Stacked bar plot of scientific names by year
#'
#' @param organism A data frame with `year` and `sci_name` columns.
#' @param organism_title Character. Title for the plot.
#'
#' @return A ggplot stacked bar chart.
#' @export
plot_bar_year <- function(organism, legend = NULL) {
  p <- organism |>
    tidyr::drop_na(year, sci_name) |>
     ggplot(aes(x = factor(year), fill = sci_name)) +
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
   if (!is.null(legend)){
     p <- p + theme(legend.position = "none")
   }
   return(p)
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









plot_monthly_occurrences_by_state <- function(data, legend = NULL) {

  # Ensure necessary columns exist
  if (!all(c("date", "obs_state", "sci_name") %in% names(data))) {
    stop("The dataset must contain 'datetime', 'obs_state', and 'sci_name' columns.")
  }

  # Add month columns
  data$month <- format(data$date, "%B")
  data$month_num <- as.numeric(format(data$date, "%m"))
  data$month <- factor(data$month, levels = month.name)

  # Create the stacked bar plot
  p <- ggplot(data, aes(x = month, fill = sci_name)) +
    geom_bar() +
    labs(
      title = paste("Monthly Distribution of", organism_title, "Occurrences by State"),
      x = "Month", y = "Number of Records", fill = "Scientific Name"
    ) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    facet_wrap(. ~ obs_state, scales = "free_y") +
    scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }
  print(p)
}





plot_weekly_occurrences_by_state <- function(data, legend = NULL) {

  # Check for necessary columns
  if (!all(c("date", "obs_state") %in% names(data))) {
    stop("The dataset must contain 'datetime' and 'obs_state' columns.")
  }

  # Prepare weekly data
  data <- data %>%
    mutate(
      date = as.Date(date),
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

  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }
  print(p)
}


plot_seasonal_occurrence_polar <- function(data, legend = NULL) {

  # Check for necessary columns
  if (!all(c("date", "obs_state") %in% names(data))) {
    stop("The dataset must contain 'datetime' and 'obs_state' columns.")
  }

  # Add date, month name, and numeric month
  data <- data %>%
    mutate(
      date = as.Date(date),
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
  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }
  print(p)
}



plot_monthly_occurrence_map <- function(data, legend = NULL) {


  data(weather_stations)
  data <- left_join(data, weather_stations, by = "ws_id")

  # Check for required columns
  required_cols <- c("obs_lat", "obs_lon", "stn_lat", "stn_lon", "date", "sci_name")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Prepare data
  data <- data %>%
    mutate(
      date = as.Date(date),
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
      aes(x = obs_lon, y = obs_lat, color = sci_name),
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
  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }

  print(p)
}






plot_monthly_occurrence_map_by_state <- function(data, legend = NULL) {

  data(weather_stations)
  data <- left_join(data, weather_stations, by = "ws_id")

  # Check required columns
  required_cols <- c("date", "obs_lat", "obs_lon", "stn_lat", "stn_lon", "obs_state")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Prepare data
  data <- data %>%
    mutate(
      date = as.Date(date),
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

  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }
  print(p)
}





plot_monthly_distribution_map <- function(data, legend = NULL) {

    data(weather_stations)
    data <- left_join(data, weather_stations, by = "ws_id")

  # Check for required columns
  required_cols <- c("date", "obs_lat", "obs_lon", "stn_lat", "stn_lon", "obs_state")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }

  # Prepare data
  data <- data %>%
    mutate(
      date = as.Date(date),
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

  if (!is.null(legend)){
    p <- p + theme(legend.position = "none")
  }
  print(p)
}

