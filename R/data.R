#### glowworms ---------------------------------------

#' Glowworms Occurrence Data (2014–2024)
#'
#' This dataset contains cleaned and enriched occurrence records for glowworms
#' (*Arachnocampa tasmaniensis*) in Australia from 2014 to 2024.
#' It includes spatial, temporal, taxonomic, and weather station metadata.
#'
#' @format A tibble with 124 rows and 14 variables:
#' \describe{
#'   \item{obs_lat}{Latitude of the observation (decimal degrees)}
#'   \item{obs_lon}{Longitude of the observation (decimal degrees)}
#'   \item{date}{Observation date (YYYY-MM-DD)}
#'   \item{time}{Observation time (HH:MM:SS, character)}
#'   \item{year}{Observation year}
#'   \item{month}{Month of the observation}
#'   \item{day}{Day of the month}
#'   \item{hour}{Hour of the day (0–23)}
#'   \item{weekday}{Day of the week (ordered factor)}
#'   \item{dayofyear}{Day of the year (1–366)}
#'   \item{sci_name}{Scientific name of the observed species}
#'   \item{record_type}{Type of observation (e.g., HUMAN_OBSERVATION)}
#'   \item{obs_state}{Australian state where the observation occurred}
#'   \item{ws_id}{ID of the nearest weather station (e.g., "949610-99999")}
#' }
#'
#' @details
#' Data was sourced via the `galah` package from the Atlas of Living Australia,
#' filtered and cleaned, then enriched by linking each record to the nearest
#' weather station using geospatial methods.
#'
#' @source Atlas of Living Australia via \pkg{galah}
#'
#' @examples
#' data(glowworms)
#' head(glowworms)
"glowworms"

#### gouldian_finch ---------------------------------------

#' Gouldian Finch Occurrence Data (2014–2024)
#'
#' This dataset contains cleaned and processed occurrence records for the Gouldian Finch
#' (*Chloebia gouldiae*) in Australia between 2014 and 2024. It includes spatial coordinates,
#' temporal details, species information, and the ID of the nearest weather station for each observation.
#'
#' @format A tibble with 3,921 rows and 14 variables:
#' \describe{
#'   \item{obs_lat}{Latitude of the observation (decimal degrees)}
#'   \item{obs_lon}{Longitude of the observation (decimal degrees)}
#'   \item{date}{Date of the observation (YYYY-MM-DD)}
#'   \item{time}{Time of the observation (HH:MM:SS)}
#'   \item{year}{Year of the observation}
#'   \item{month}{Month (1–12)}
#'   \item{day}{Day of the month}
#'   \item{hour}{Hour extracted from the time (0–23)}
#'   \item{weekday}{Day of the week (as ordered factor)}
#'   \item{dayofyear}{Day of the year (1–366)}
#'   \item{sci_name}{Scientific name of the species}
#'   \item{record_type}{Type of observation (e.g., HUMAN_OBSERVATION)}
#'   \item{obs_state}{Australian state where the observation was recorded}
#'   \item{ws_id}{Nearest weather station ID (e.g., "948280-99999")}
#' }
#'
#' @details
#' The data was retrieved from the Atlas of Living Australia using the \pkg{galah} package,
#' then standardized, cleaned, and matched to the three closest weather stations using geospatial tools.
#'
#' @source Atlas of Living Australia via \pkg{galah}
#' @seealso \code{\link{glowworms}}, \code{\link{weather_data}}
#'
#' @examples
#' data(gouldian_finch)
#' head(gouldian_finch)
"gouldian_finch"


#### manta_rays ---------------------------------------

#' Manta Ray Occurrence Data (2014–2024)
#'
#' This dataset contains occurrence records for the reef manta ray (*Mobula alfredi*)
#' observed in Australian waters from 2014 to 2024. The data includes spatial and temporal
#' metadata, species identifiers, and linked weather station IDs.
#'
#' @format A tibble with 1,088 rows and 14 variables:
#' \describe{
#'   \item{obs_lat}{Latitude of the observation (decimal degrees)}
#'   \item{obs_lon}{Longitude of the observation (decimal degrees)}
#'   \item{date}{Date of the observation (YYYY-MM-DD)}
#'   \item{time}{Time of the observation (HH:MM:SS)}
#'   \item{year}{Year of the observation}
#'   \item{month}{Month (1–12)}
#'   \item{day}{Day of the month}
#'   \item{hour}{Hour extracted from the time (0–23)}
#'   \item{weekday}{Day of the week (as ordered factor)}
#'   \item{dayofyear}{Day of the year (1–366)}
#'   \item{sci_name}{Scientific name — all observations are \emph{Mobula alfredi}}
#'   \item{record_type}{Type of observation (e.g., MACHINE_OBSERVATION)}
#'   \item{obs_state}{Australian state where the observation occurred (may be missing)}
#'   \item{ws_id}{Nearest weather station ID (e.g., "947800-99999")}
#' }
#'
#' @details
#' Records were accessed using the \pkg{galah} package and filtered specifically
#' for *Mobula alfredi*. Data has been cleaned and enriched with spatial proximity
#' to weather stations for climate-related analysis.
#'
#' @source Atlas of Living Australia via \pkg{galah}
#' @seealso \code{\link{gouldian_finch}}, \code{\link{weather_data}}
#'
#' @examples
#' data(manta_rays)
#' head(manta_rays)
"manta_rays"


#### orchids ---------------------------------------

#' Orchid Occurrence Data (2014–2024)
#'
#' This dataset contains over 300,000 occurrence records of orchid species (*Orchidaceae*)
#' in Australia from 2014 to 2024. The data includes spatial, temporal, and taxonomic
#' details, as well as associated weather station metadata for ecological analysis.
#'
#' @format A tibble with 302,123 rows and 14 variables:
#' \describe{
#'   \item{obs_lat}{Latitude of the observation (decimal degrees)}
#'   \item{obs_lon}{Longitude of the observation (decimal degrees)}
#'   \item{date}{Date of the observation (YYYY-MM-DD)}
#'   \item{time}{Time of the observation (HH:MM:SS)}
#'   \item{year}{Year of the observation}
#'   \item{month}{Month (1–12)}
#'   \item{day}{Day of the month}
#'   \item{hour}{Hour extracted from the time (0–23)}
#'   \item{weekday}{Day of the week (as ordered factor)}
#'   \item{dayofyear}{Day of the year (1–366)}
#'   \item{sci_name}{Scientific name of the observed orchid species}
#'   \item{record_type}{Type of observation (e.g., HUMAN_OBSERVATION, PRESERVED_SPECIMEN)}
#'   \item{obs_state}{Australian state where the observation occurred (may be missing)}
#'   \item{ws_id}{Nearest weather station ID linked to the observation}
#' }
#'
#' @details
#' The data was collected using the \pkg{galah} package from the Atlas of Living Australia,
#' cleaned, and linked to nearby weather stations for ecological and climatic studies.
#' The records span multiple orchid genera and include a range of observation types.
#'
#' @source Atlas of Living Australia via \pkg{galah}
#' @seealso \code{\link{glowworms}}, \code{\link{gouldian_finch}}, \code{\link{weather_data}}
#'
#' @examples
#' data(orchids)
#' head(orchids)
"orchids"

#### top_stations ---------------------------------------

#' Top Weather Stations for Each Organism
#'
#' A lookup table identifying the top 3 most frequently linked weather stations
#' for each focal organism in the ecotourism package. These stations were selected
#' based on the number of linked observations across a 10-year period (2014–2024).
#'
#' @format A tibble with 12 rows and 2 variables:
#' \describe{
#'   \item{organism}{Name of the organism (e.g., "glowworms", "orchids")}
#'   \item{ws_id}{Weather station ID (e.g., "948720-99999")}
#' }
#'
#' @details
#' This table was created by counting the frequency of `ws_id` assignments within each organism dataset
#' and selecting the top 3 stations per organism. These top stations are used for downloading daily
#' weather data via the \pkg{GSODR} package.
#'
#' @seealso \code{\link{weather_data}}, \code{\link{weather_stations}}
#'
#' @examples
#' data(top_stations)
#' head(top_stations)
"top_stations"

#### weather_data ---------------------------------------

#' Daily Weather Data for Top Stations (2014–2024)
#'
#' This dataset contains daily weather observations for the top weather stations
#' associated with focal species in the ecotourism package. Data spans from 2014
#' to 2024 and includes temperature, humidity, precipitation, and wind measures.
#'
#' @format A tibble with 35,527 rows and 18 variables:
#' \describe{
#'   \item{ws_id}{Weather station ID (e.g., "948720-99999")}
#'   \item{stn_lat}{Latitude of the weather station}
#'   \item{stn_lon}{Longitude of the weather station}
#'   \item{date}{Observation date (YYYY-MM-DD)}
#'   \item{year}{Year of observation}
#'   \item{month}{Month of observation (1–12)}
#'   \item{day}{Day of the month}
#'   \item{weekday}{Day of the week (as ordered factor)}
#'   \item{dayofyear}{Day of the year (1–366)}
#'   \item{temp}{Average temperature (°C)}
#'   \item{min}{Minimum temperature (°C)}
#'   \item{max}{Maximum temperature (°C)}
#'   \item{dewp}{Dew point temperature (°C)}
#'   \item{rh}{Relative humidity (\%)}
#'   \item{prcp}{Precipitation (mm)}
#'   \item{rainy}{Binary flag indicating whether PRCP > 5 mm (1 = rainy day)}
#'   \item{wind_speed}{Average wind speed (m/s)}
#'   \item{max_speed}{Maximum sustained wind speed (m/s)}
#' }
#'
#' @details
#' The weather data was retrieved from the Global Surface Summary of the Day (GSOD)
#' dataset via the \pkg{GSODR} package for the top 3 weather stations per organism
#' in the ecotourism project. This data supports climate-biodiversity interaction analyses.
#'
#' @source GSOD via \pkg{GSODR}
#' @seealso \code{\link{top_stations}}, \code{\link{glowworms}}, \code{\link{gouldian_finch}}, \code{\link{weather_stations}}
#'
#' @examples
#' data(weather_data)
#' head(weather_data)
"weather_data"



#### weather_stations ---------------------------------------


#' Australian Weather Station Metadata
#'
#' This dataset contains metadata for 732 weather stations across Australia,
#' including coordinates, station names, and geocoded location details.
#'
#' @format A tibble with 732 rows and 7 variables:
#' \describe{
#'   \item{ws_id}{Weather station ID (e.g., "941000-99999")}
#'   \item{stname}{Station name (e.g., "KALUMBURU")}
#'   \item{stn_lat}{Latitude of the station (decimal degrees)}
#'   \item{stn_lon}{Longitude of the station (decimal degrees)}
#'   \item{address}{Full geocoded address (from reverse geocoding)}
#'   \item{stn_city}{Parsed city or locality name}
#'   \item{stn_state}{Australian state or territory}
#' }
#'
#' @details
#' This data was derived from the GSOD inventory using the \pkg{GSODR} package,
#' filtered for Australian stations, and geocoded using OpenStreetMap APIs. It is
#' used to match ecological observations with relevant local weather conditions.
#'
#' @source GSOD inventory via \pkg{GSODR}; geocoded with OpenStreetMap
#' @seealso \code{\link{weather_data}}, \code{\link{top_stations}}, \code{\link{gouldian_finch}}
#'
#' @examples
#' data(weather_stations)
#' head(weather_stations)
"weather_stations"



#### tourism_region ---------------------------------------

#' Tourism Regions and Nearest Weather Stations
#'
#' A dataset containing the locations of Australian tourism regions,
#' their geographic coordinates, and the nearest Bureau of Meteorology
#' weather station. Each region is assigned a unique identifier for
#' linking to other tourism datasets.
#'
#' @format A data frame with `r nrow(tourism_region)` rows and 5 variables:
#' * **region**: Name of the tourism region. Tourism regions are defined by
#'   Tourism Research Australia and generally formed through the aggregation of
#'   Statistical Local Areas (SLAs) or other ABS-defined geographies.
#' * **lon**: Longitude of the tourism region representative point (WGS84).
#' * **lat**: Latitude of the tourism region representative point (WGS84).
#' * **region_id**: Unique integer identifier for the tourism region. Useful
#'   for joining with other tourism-related datasets.
#' * **ws_id**: Identifier of the nearest Bureau of Meteorology weather station
#'   to the tourism region.
#'
#' @details
#' Coordinates for each tourism region are intended to represent a
#' central location within the region (e.g., polygon centroid). The
#' nearest weather station is determined using great-circle distance
#' calculations based on the Bureau of Meteorology's official station list.
#'
#' @references
#' Tourism Research Australia: \url{https://www.tra.gov.au}
#' Australian Bureau of Meteorology: \url{http://www.bom.gov.au}
#'
#' @docType data
#' @name tourism_region
#' @usage tourism_region
#' @examples
#' data(tourism_region)
#' head(tourism_region)
"tourism_region"



#### tourism_quarterly ------------------------------------


#' Quarterly Tourism Trips by Region and Purpose
#'
#' A dataset containing quarterly estimates of overnight tourism trips
#' in Australia, broken down by trip purpose and tourism region.
#'
#' @format A data frame with `r nrow(tourism_quarterly)` rows and 4 variables:
#' * **quarter**: Quarter label in the format `"Month YYYY nn"`, where
#'   `nn` is the month number for the start of the quarter (e.g.,
#'   `"December 1998 01"`).
#' * **purpose**: Purpose of visit category:
#'   - `"Holiday"`
#'   - `"Visiting"` (visiting friends and relatives)
#'   - `"Business"`
#'   - `"Other"`
#'   - `"Total"` (all purposes combined)
#' * **trips**: Number of overnight trips (in thousands).
#' * **region_id**: Unique integer identifier linking to the
#'   \code{\link{tourism_region}} dataset.
#'
#' @details
#' Tourism regions are formed through the aggregation of Statistical
#' Local Areas (SLAs) or similar ABS-defined geographies, as determined
#' by state and territory tourism authorities. This dataset is designed
#' for analysis of seasonal tourism patterns and can be joined to
#' \code{\link{tourism_region}} for spatial analysis.
#'
#' @references
#' Tourism Research Australia: \url{https://www.tra.gov.au}
#'
#' @docType data
#' @name tourism_quarterly
#' @usage tourism_quarterly
#' @examples
#' data(tourism_quarterly)
#' head(tourism_quarterly)
"tourism_quarterly"



#### oz_lga ---------------------------------------

#' oz_lga
#'
#' LGA polygons for Australia
#'
#' @name oz_lga
#' @docType data
#' @format A spatial polygon object
#' @keywords datasets
#' @examples
#'
#' head(oz_lga)
"oz_lga"

