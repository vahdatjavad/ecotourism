## ----"markdown initiation", include = FALSE-----------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
source("vignette-utils.R")

## ----echo=FALSE---------------------------------------------------------------
# global variables
organism_name <- "glowworms"
organism_title <- "Glowworms"
taxa     <- "Arachnocampa"
start    <- 2014
end      <- 2024

## ----"request data ALA", eval=FALSE, message=FALSE, warning=FALSE, include=FALSE----
# 
# organism_raw <- obs_data(taxa, start, end) |> polished_data()
# # Save data
# mysave_raw(organism_name, organism_raw)

## ----"print head of data", echo=FALSE-----------------------------------------
organism_raw <- myload_raw(organism_name)
organism_raw |> slice_head(n = 3) |> as_tibble() |> glimpse()

## ----"number of occ in state", echo=FALSE-------------------------------------
organism_raw |> my_count(scientificName, obs_state) |> as_tibble() 

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------

# Clean and prepare data
organism_raw |> 
  filter(!is.na(obs_lat), !is.na(obs_lon), !is.na(month), 
         scientificName == "Arachnocampa" | 
         scientificName == "Arachnocampa flava" |
         scientificName == "Arachnocampa tasmaniensis") |> 
  plot_map1(color_by = scientificName)


## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------

# Set radius threshold in meters (250 km)
radius_threshold <- 250000


# Split into unknowns and references
unknowns <- organism_raw |> 
  filter(scientificName == "Arachnocampa")

references <- organism_raw |> 
  filter(scientificName == "Arachnocampa flava")

# Function to assign if within distance
assign_if_close_to_flava <- function(lat, lon, flava_data, radius) {
  dists <- distHaversine(
    matrix(c(lon, lat), ncol = 2),
    matrix(c(flava_data$obs_lon, flava_data$obs_lat), ncol = 2)
  )
  if (any(dists <= radius)) {
    return("Arachnocampa flava")
  } else {
    return("Arachnocampa")  # Keep unchanged
  }
}

# Apply to unknowns
unknowns_updated <- unknowns |> 
  rowwise() |> 
  mutate(scientificName = assign_if_close_to_flava(obs_lat, obs_lon, references, radius_threshold)) |> 
  ungroup()


# Combine with other records
organism <- organism_raw |> 
  filter(scientificName != "Arachnocampa") |> 
  bind_rows(unknowns_updated) |> 
  filter(!is.na(obs_lat), !is.na(obs_lon), !is.na(month), 
         scientificName == "Arachnocampa flava" |
         scientificName == "Arachnocampa tasmaniensis")

  

mysave(organism_name, organism)

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
# Clean and prepare data
organism |> plot_map1(color_by = scientificName)


## ----"number of occ in state v2", echo=FALSE----------------------------------
organism |> my_count(scientificName, obs_state) |> as_tibble() 

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
organism |>  plot_bar_week()

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
organism |> plot_bar_month()

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
organism |> plot_bar_year()

## ----echo=FALSE, message=FALSE------------------------------------------------
attach_nearest_station(organism_name)

## ----eval=TRUE, include=TRUE, echo=FALSE--------------------------------------
organism_ws <- myload_ws(organism_name)

head(organism_ws, n = 2) |> as_tibble() |> glimpse()

## ----echo=FALSE---------------------------------------------------------------

summarize_state_frequencies(organism_name)


## ----echo=FALSE, fig.width=8, fig.height=6------------------------------------
plot_monthly_occurrences_by_state(organism_name)

## ----echo=FALSE, fig.height=6, fig.width=8, message=FALSE, warning=FALSE------
plot_weekly_occurrences_by_state(organism_name)

## ----echo=FALSE, fig.width=8, fig.height=6------------------------------------
plot_seasonal_occurrence_polar(organism_name)

## ----echo=FALSE, fig.height=6, fig.width=8, message=FALSE, warning=FALSE------

plot_monthly_occurrence_map(organism_name)



## ----echo=FALSE, fig.height=6, fig.width=8, message=FALSE, warning=FALSE------

plot_monthly_occurrence_map_by_state(organism_name)


## ----echo=FALSE, fig.height=8, fig.width=10, message=FALSE, warning=FALSE-----
plot_monthly_distribution_map(organism_name)

