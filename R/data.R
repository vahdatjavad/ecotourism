#' Cuttlefish Sightings Dataset
#' 
#' Sightings of cuttlefish downloaded from https://www.ala.org.au
#'
#' \itemize{
#'   \item id: Record ID given by Atlas
#'   \item name: Scientific name
#'   \item lon, lat: Spatial coordinates of the sighting
#'   \item date, year, month, wday, time: Date and time of sighting
#'   \item source: Original provider of the record
#'   \item stnid: Station ID for the nearest weather station
#' }
#'
#' @format A data frame with 750 rows and 9 variables
#' @source https://www.ala.org.au
#' @keywords datasets
#' @rdname cuttlefish
#' @examples
#' data(cuttlefish)
#' head(cuttlefish)
"cuttlefish"


#' Weather Data from Sightings Locations
#' 
#' Daily records of precipitation, and minimum and maximum temperature, 
#' covering locations and times of sightings, as available using the `rnoaa` package.
#'
#' \itemize{
#'   \item stnid: Station ID
#'   \item lon, lat, elev: Spatial coordinates and elevation of the station
#'   \item date: Date of the record
#'   \item prcp: Precipitation in mm
#'   \item tmax, tmin: Temperature in Celsius
#' }
#'
#' @format A data frame with 15,274 rows and 9 variables
#' @keywords datasets
#' @rdname weather
#' @examples
#' data(weather)
#' head(weather)
"weather"

#' Quarterly Tourism Data
#'
#' Quarterly records of tourist counts in regions across Australia.
#'
#' \itemize{
#'   \item Quarter: The quarter in which the tourism activity was recorded (e.g., 2019 Q1)
#'   \item Region: Geographic region where the data was collected
#'   \item Purpose: Purpose of the trip (e.g., Holiday, Business)
#'   \item Trips: Number of trips
#'   \item lon, lat: Coordinates of the region
#'   \item stnid: Station ID used for matching with weather data
#' }
#'
#' @format A data frame with 1,228,000 rows and 7 variables
#' @keywords datasets
#' @rdname tourism
#' @examples
#' data(tourism)
#' head(tourism)
#'
#' # Example of converting to tsibble (requires tsibble package)
#' # library(tsibble)
#' # tourism <- tourism |>
#' #   dplyr::mutate(Quarter = yearquarter(lubridate::myd(Quarter))) |>
#' #   as_tsibble(key = c(Region, Purpose), index = Quarter)
"tourism"


#' Local Government Areas (LGA) Polygons for Australia
#'
#' A spatial polygons object representing the boundaries of local government areas (LGAs) in Australia.
#'
#' @format A spatial polygons object 
#' @keywords datasets
#' @rdname oz_lga
#' @examples
#' data(oz_lga)
#' head(oz_lga)
"oz_lga"


#' Nearest Weather Stations for Cuttlefish Records
#'
#' A dataset of the nearest weather stations corresponding to each record in the cuttlefish sightings data.
#'
#' \itemize{
#'   \item stnid: Station ID
#'   \item lon, lat: Spatial coordinates of the station
#' }
#'
#' @format A data frame with 750 rows and 3 variables
#' @keywords datasets
#' @rdname stations
#' @examples
#' data(stations)
#' head(stations)
"stations"