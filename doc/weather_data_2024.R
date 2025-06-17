## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
# load required packages
library(GSODR)
library(dplyr)
library(ggplot2)
library(tidyverse)

## ----echo=FALSE---------------------------------------------------------------
# find top 3 station 

load("../data/orchids_2024_ws.rda")
load("../data/weather_stations.rda")

orchids_station_counts <- orchids_2024_ws %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) |> 
  distinct()

head(orchids_station_counts, n = 3)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# orchids_top_stations <- orchids_station_counts |> slice_max(n, n=3)
# 
# orchids_weather_data_list <- lapply(orchids_top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine if needed
# orchids_top_weather <- dplyr::bind_rows(orchids_weather_data_list)
# 
# usethis::use_data(orchids_top_weather)

## ----echo=FALSE---------------------------------------------------------------
organism <- "gouldian_finch"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)
# 

## ----echo=FALSE---------------------------------------------------------------
organism <- "hooded_parrot"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)
# 

## ----echo=FALSE---------------------------------------------------------------
organism <- "golden_shouldered_parrot"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)
# 

## ----echo=FALSE---------------------------------------------------------------
organism <- "southern_black_throated_finch"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)
# 

## ----echo=FALSE---------------------------------------------------------------
organism <- "whales"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)
# 

## ----echo=FALSE---------------------------------------------------------------
organism <- "whale_sharks"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)
# 

## ----echo=FALSE---------------------------------------------------------------
organism <- "koala"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)
# 

## ----echo=FALSE---------------------------------------------------------------
organism <- "platypus"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "wombat"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "glowworms"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "penguins"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "giant_cuttlefish"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "manta_rays"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "saltwater_crocodiles"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "thorny_devil"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

## ----echo=FALSE---------------------------------------------------------------
organism <- "sea_turtles"
# Load required data
load(paste0("../data/", organism, "_2024_ws.rda"))
load("../data/weather_stations.rda")

# Identify top 3 stations
station_counts <- get(paste0(organism, "_2024_ws")) %>%
  count(weather_station_id, sort = TRUE) %>%
  left_join(weather_stations, by = c("weather_station_id" = "stnid")) %>%
  distinct()

head(station_counts, n = 3)


## ----echo=FALSE, eval=FALSE---------------------------------------------------
# # Get weather data for top 3 stations (optional)
# top_stations <- station_counts |> slice_max(n, n = 3)
# 
# weather_data_list <- lapply(top_stations$weather_station_id, function(stn) {
#   get_GSOD(years = 2024, station = stn)
# })
# 
# # Combine and save
# top_weather <- dplyr::bind_rows(weather_data_list)
# 
# # Dynamically assign it to the global environment under a specific name
# obj_name <- paste0(organism, "_top_weather")
# file_path <- file.path("../data", paste0(obj_name, ".rda"))
# assign(obj_name, top_weather)
# 
# save(list = obj_name, file = file_path)

