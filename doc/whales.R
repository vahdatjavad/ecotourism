## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
# load required packages
library(galah)
library(dplyr)
library(ggplot2)
library(tidyverse)

## ----eval=FALSE, message=FALSE, warning=FALSE, include=FALSE------------------
# # Set up ALA Access
# galah_config(email = "vahdatjavad@gmail.com")
# 
# # Define and perform the search
# whale_taxon <- search_taxa("Humpback whale")
# occ_data <- galah_call() |>
#   galah_identify(whale_taxon) |>
#   galah_filter(year == 2024) |>
#   galah_select(decimalLatitude, decimalLongitude, year, eventDate, scientificName) |>
#   atlas_occurrences()
# 
# # Drop records with missing coordinates
# whales_2024 <- occ_data |>
#   filter(!is.na(decimalLatitude), !is.na(decimalLongitude), !is.na(eventDate)) |>
#   rename(lat = decimalLatitude, lon = decimalLongitude)
# 
# # Save data
# usethis::use_data(whales_2024)

## ----echo=FALSE---------------------------------------------------------------
load("../data/whales_2024.rda")
head(whales_2024)

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
whales_2024$month <- format(whales_2024$eventDate, "%B")
whales_2024$month_num <- as.numeric(format(whales_2024$eventDate, "%m"))

ggplot(whales_2024, aes(x = factor(month, levels = month.name))) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Monthly Distribution of Whale Occurrences (2024)",
    x = "Month", y = "Number of Records"
  ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
library(lubridate)
library(tidyr)

whales_2024$date <- as.Date(whales_2024$eventDate)

date_range <- range(whales_2024$date)
total_days <- as.numeric(diff(date_range))
obs_days <- n_distinct(whales_2024$date)
gap_days <- total_days - obs_days

daily_counts <- whales_2024 %>%
  count(date) %>%
  complete(date = seq(min(date), max(date), by = "day"), 
           fill = list(n = 0))

ggplot(daily_counts, aes(x = date, y = n)) +
  geom_col(fill = "#1f77b4") +
  geom_hline(yintercept = 0, color = "gray30") +
  labs(title = paste0("Observation Gaps: ", gap_days, " days missing"),
       x = "Date", y = "Daily Observations") +
  theme_minimal()

## ----echo=FALSE---------------------------------------------------------------
load("../data/whales_2024.rda")
load("../data/weather_stations.rda")

## ----eval=FALSE, include=TRUE, echo=FALSE-------------------------------------
# library(geosphere)
# 
# nearest_station_ids <- sapply(1:nrow(whales_2024), function(i) {
#   dists <- distHaversine(
#     cbind(weather_stations$lon, weather_stations$lat),
#     c(whales_2024$lon[i], whales_2024$lat[i])
#   )
#   weather_stations$stnid[which.min(dists)]
# })
# 
# whales_2024$weather_station_id <- nearest_station_ids
# whales_2024_ws <- whales_2024 %>%
#   left_join(weather_stations, by = c("weather_station_id" = "stnid"))
# 
# usethis::use_data(whales_2024_ws)

## ----eval=TRUE, include=TRUE, echo=FALSE--------------------------------------
load("../data/whales_2024_ws.rda")
head(whales_2024_ws, n = 3)

## ----echo=FALSE---------------------------------------------------------------
load("../data/whales_2024_ws.rda")
state_freq <- table(whales_2024_ws$state)
state_freq <- sort(state_freq, decreasing = TRUE)
state_freq_df <- as.data.frame(state_freq)
colnames(state_freq_df) <- c("State", "Frequency")
state_freq_df

## ----echo=FALSE, fig.width=8, fig.height=6------------------------------------
whales_2024_ws$month <- format(whales_2024_ws$eventDate, "%B")
whales_2024_ws$month_num <- as.numeric(format(whales_2024_ws$eventDate, "%m"))

ggplot(whales_2024_ws, aes(x = factor(month, levels = month.name))) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Monthly Distribution of Whale Occurrences (2024) by State",
    x = "Month", y = "Number of Records"
  ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  facet_wrap(. ~ state, scales = "free_y") +
  scale_y_continuous(expand = expansion(mult = c(0, 0.1)))

## ----echo=FALSE, fig.height=6, fig.width=8, message=FALSE, warning=FALSE------
whales_2024_ws$date <- as.Date(whales_2024_ws$eventDate)
whales_2024_ws <- whales_2024_ws %>%
  mutate(week = week(date),
         week_start = floor_date(date, "week"))

weekly_counts <- whales_2024_ws %>%
  count(week_start, state)

ggplot(weekly_counts, aes(x = week_start, y = n, group = state)) +
  geom_line(color = "#2ca02c") +
  geom_smooth(method = "loess", se = FALSE, color = "#d62728") +
  facet_wrap(~state, scales = "free_y") +
  labs(
    title = "Weekly Occurrence Patterns of Whales (2024) with Trend Lines",
    x = "Week Starting", y = "Observations"
  ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----echo=FALSE, fig.width=8, fig.height=6------------------------------------
whales_2024_ws <- whales_2024_ws %>%
  mutate(
    date = as.Date(eventDate),
    month = format(date, "%B"),
    month_num = as.numeric(format(date, "%m"))
  )

state_monthly <- whales_2024_ws %>%
  group_by(state, month) %>%
  summarize(count = n(), .groups = "drop") %>%
  group_by(state) %>%
  mutate(percent = 100 * count / sum(count))

ggplot(state_monthly, aes(x = month, y = percent, color = state, group = state)) +
  geom_line(linewidth = 1.5) +
  coord_polar() +
  scale_x_discrete(limits = month.name) +
  labs(title = "Seasonal Patterns of Whale Occurrences by State",
       x = NULL, y = "Percentage of Occurrences") +
  theme_minimal()

## ----echo=FALSE, fig.height=6, fig.width=8, message=FALSE, warning=FALSE------
# Load required packages
library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Clean and prepare data
df <- whales_2024_ws %>%
  filter(!is.na(lat.x), !is.na(lon.x), !is.na(month)) %>%
  mutate(month = factor(month, levels = month.name))  # Ensure proper month order

# Load Australia base map (sf object)
aus_map <- ne_states(country = "Australia", returnclass = "sf")

# Create faceted map by month
ggplot() +
  geom_sf(data = aus_map, fill = "gray95", color = "gray50") +
  geom_point(data = df, aes(x = lon.x, y = lat.x, color = state), alpha = 0.6, size = 1.5) +
  coord_sf(xlim = c(110, 155), ylim = c(-45, -10)) +
  theme_minimal() +
  theme(
    strip.text = element_text(face = "bold"),
    panel.grid = element_blank()
  ) +
  labs(
    title = "Distribution of Whale Sightings in Australia (2024)",
    x = "Longitude",
    y = "Latitude",
    color = "State"
  )



## ----echo=FALSE, fig.height=8, fig.width=10, message=FALSE, warning=FALSE-----
# Load required packages
library(tidyverse)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)

# Clean and prepare data
df <- whales_2024_ws %>%
  filter(!is.na(lat.x), !is.na(lon.x), !is.na(month)) %>%
  mutate(month = factor(month, levels = month.name))  # Ensure proper month order

# Load Australia base map (sf object)
aus_map <- ne_states(country = "Australia", returnclass = "sf")

# Create faceted map by month
ggplot() +
  geom_sf(data = aus_map, fill = "gray95", color = "gray50") +
  geom_point(data = df, aes(x = lon.x, y = lat.x, color = state), alpha = 0.6, size = 1.5) +
  coord_sf(xlim = c(110, 155), ylim = c(-45, -10)) +
  facet_wrap(~ month, ncol = 4) +
  theme_minimal() +
  theme(
    strip.text = element_text(face = "bold"),
    panel.grid = element_blank()
  ) +
  labs(
    title = "Monthly Distribution of Whale Sightings in Australia (2024)",
    x = "Longitude",
    y = "Latitude",
    color = "State"
  )



