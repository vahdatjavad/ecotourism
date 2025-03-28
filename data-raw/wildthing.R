# This code is for processing the raw data into a nice size.
library(tidyverse)
library(ozmaps)
library(ggthemes)
library(rmapshaper)
library(plotly)
library(lubridate)
library(tsibble)
library(rnoaa)
library(galah)

# Original file, wrong name
#load("data-raw/giant_cuttlefish.rda")
#cuttlefish <- new_sepia_apama
#save(cuttlefish, file="data-raw/giant_cuttlefish.rda")
galah_config(email = "dicook@monash.edu")
sepia <- galah_call() |>
  galah_identify("Sepia apama") |>
  galah_select(basisOfRecord, recordedBy, recordedByID, eventType, group = c("basic", "event")) |>
  atlas_occurrences()

write_csv(sepia, file="data-raw/giant_cuttlefish.csv")

# Clean data
cuttlefish <- sepia |>
  rename(lon = decimalLongitude,
         lat = decimalLatitude,
         date = eventDate,
         name = scientificName,
         id = recordID,
         source = dataResourceName) |>
  mutate(year = year(date),
         month = month(date, label=TRUE),
         wday = wday(date, label=TRUE, week_start = 1)) |>
  select(id, name, lon, lat, date,
         year, month, wday, source)

# Check dates
cuttlefish |>
  group_by(year) |>
  summarise(count = n()) |>
  ggplot(aes(year, count)) +
    geom_point() +
  geom_smooth(se=FALSE, colour="grey60")

# Select only after 2000
cuttlefish <- cuttlefish |>
  filter(year > 1999)

# Check time of year
cuttlefish |>
  group_by(month) |>
  summarise(count = n()) |>
  ggplot(aes(month, count)) +
  geom_point() +
  geom_smooth(se=FALSE, colour="grey60")
save(cuttlefish, file="data/cuttlefish.rda")

# Check geography
oz <- ozmap_data("abs_lga")
oz_small <- ms_simplify(oz)
oz_lga <- oz_small
save(oz_lga, file="data/oz_lga.rda")

ggplot(oz_lga) +
  geom_sf(colour="white", fill="grey90") +
  geom_point(data=cuttlefish, aes(x=lon, y=lat,
                                  label=date),
             colour="#EA6900", alpha=0.5) +
  xlim(c(113.09, 153.38)) +
  ylim(c(-43.38, -10.41)) +
  theme_map()
ggplotly()

# Note the curious line through NSW!

# Zoom to small regions
whyalla <- tibble(lon=137.5756, lat=-33.0346)
ggplot(oz_lga) +
  geom_sf(colour="white", fill="grey90") +
  geom_point(data=cuttlefish, aes(x=lon, y=lat,
                                  label=date),
             colour="#EA6900", alpha=0.5) +
  xlim(c(136, 138.5)) +
  ylim(c(-35.95, -32.5)) +
  geom_point(data=whyalla, aes(x=lon, y=lat),
             colour="#3B99B1", shape=3, size=4) +
  theme_map()
ggplotly()

# Extract centroids
oz_centroids <- st_centroid(oz_lga)
oz_coords <- st_coordinates(oz_centroids)
oz_lga_cent <- oz_centroids |>
  select(NAME) |>
  rename(name = NAME) |>
  as_tibble() |>
  mutate(lon = oz_coords[,1],
         lat = oz_coords[,2])
write_csv(oz_lga_cent, file="data-raw/oz_lga_cent.csv")

# Remove extra stuff
oz_lga_cent <- oz_lga_cent |>
  select(name, lon, lat) |>
  mutate(name = str_remove(name, "\\([^()]*\\)"))
write_csv(oz_lga_cent, file="data-raw/oz_lga_cent.csv")

oz_lga_cent <- oz_lga_cent |>
  mutate(name = str_trim(name, "right"))
write_csv(oz_lga_cent, file="data-raw/oz_lga_cent.csv")

# Weather
load("data-raw/weather.rda")
weather <- joined |>
  select(id, long, lat, elev, name, date, prcp, tmax, tmin) |>
  rename(stnid = id, lon=long)
save(weather, file="data/weather.rda")

# More stations
download_stns <- ghcnd_stations()
aus_stations <- download_stns |>
  filter(str_starts(id, "ASN")) |>
  filter(last_year >= 2020) |>
  mutate(wmo_id = as.numeric(wmo_id),
         name = str_to_lower(name)) |>
  select(-state, -gsn_flag) |>
  rename(stnid = id,
         lon = longitude,
         lat = latitude)

ggplot(oz_lga) +
  geom_sf(colour="white", fill="grey90") +
  geom_point(data=cuttlefish, aes(x=lon, y=lat,
                                  label=date),
             colour="#EA6900", alpha=0.5) +
  geom_point(data=aus_stations, aes(x=lon, y=lat,
                                  label=stnid),
             colour="#3B99B1", alpha=0.5, shape=4) +
  xlim(c(113.09, 153.38)) +
  ylim(c(-43.38, -10.41)) +
  theme_map()
ggplotly()

write_csv(aus_stations, file="data-raw/aus_stations.csv")

# Weather data for subset of stations
#stn1 <- ghcnd(stationid = stations$stnid)
stn1_tidy <- meteo_tidy_ghcnd(stationid = stations$stnid, date_min = "2000-01-01")

# Tourism
# load("data-raw/tourism.rda") # Qtr isn't saved correctly
domestic_trips <- read_csv(
  "data-raw/domestic_trips_2023-10-08.csv",
  skip = 9,
  col_names = c("Quarter", "Region", "Holiday", "Visiting", "Business", "Other", "Total"),
  n_max = 248056
) %>% select(-X8)

# fill NA in "Quarter" using the last obs
fill_na <- domestic_trips %>%
  fill(Quarter, .direction = "down") %>%
  filter(Quarter != "Total")

# gather Stopover purpose of visit
long_data <- fill_na %>%
  pivot_longer(cols=Holiday:Total,
               names_to="Purpose",
               values_to="Trips")

# manipulate Quarter
qtr_data <- long_data %>%
  mutate(
    Quarter = paste(gsub(" quarter", "", Quarter), "01")
  )

tourism <- qtr_data
save(tourism, file="data/tourism.rda")

# Try to add lon, lat
name_match <- tourism |>
  mutate(m1 = str_detect(tourism$Region, oz_lga_cent$name[1]))

name_match |> filter(m1)

tourism_latlon <- tourism |>
  mutate(lon = NA, 
         lat = NA)
for (i in 1:nrow(oz_lga_cent)) {
  cat(i, "\n")
  name_match <- str_detect(tourism$Region, oz_lga_cent$name[i])
  tourism_latlon <- tourism_latlon |>
    mutate(lon = ifelse(name_match, oz_lga_cent$lon[i], lon),
           lat = ifelse(name_match, oz_lga_cent$lat[i], lat))
}
tourism <- tourism_latlon
save(tourism, file="data/tourism.rda")
