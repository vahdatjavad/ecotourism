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
#' @seealso \code{\link{glowworms}}, \code{\link{weather}}
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
#' @seealso \code{\link{gouldian_finch}}, \code{\link{weather}}
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
#' @seealso \code{\link{glowworms}}, \code{\link{gouldian_finch}}, \code{\link{weather}}
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
#' @seealso \code{\link{weather}}, \code{\link{weather_stations}}
#'
#' @examples
#' data(top_stations)
#' head(top_stations)
"top_stations"

#### weather ---------------------------------------

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
#' data(weather)
#' head(weather)
"weather"



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
#' @seealso \code{\link{weather}}, \code{\link{top_stations}}, \code{\link{gouldian_finch}}
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
#' @format A tibble with 2,353 rows and 7 variables:
#' * **state**: Australian state or territory abbreviation.
#' * **region**: Name of the tourism region. Tourism regions are defined by
#'   Tourism Research Australia and generally formed through the aggregation of
#'   Statistical Area Level 2 (SA2) geographies.
#' * **sa2**: Name of the SA2 area.
#' * **lon**: Longitude of the SA2 representative point (WGS84).
#' * **lat**: Latitude of the SA2 representative point (WGS84).
#' * **ws_id**: Identifier of the nearest Bureau of Meteorology weather station
#'   to the SA2 area.
#' * **sa2_code_tra**: Character SA2 code used by Tourism Research Australia.
#'   Join this field to the identically named field in the detailed tourism
#'   datasets after harmonising its type.
#'
#' @details
#' Coordinates for each SA2 are intended to represent a central location
#' within the area (e.g., polygon centroid). The
#' nearest weather station is determined using great-circle distance
#' calculations based on the Bureau of Meteorology's official station list.
#'
#' @references
#' Tourism Research Australia: \url{https://www.tra.gov.au}
#' Australian Bureau of Meteorology.
#'
#' @docType data
#' @name tourism_region
#' @usage tourism_region
#' @examples
#' data(tourism_region)
#' head(tourism_region)
"tourism_region"



#### tourism_reason ---------------------------------------

#' Monthly Tourism Trips by Stopover Reason
#'
#' Estimated domestic overnight trips to Australian SA2 areas by month and
#' stopover reason. The data contain only observations with non-zero trip
#' estimates and non-zero survey sample sizes.
#'
#' @format A tibble with 196,044 rows and 6 variables:
#' * **year**: Calendar year, from 2014 to 2024.
#' * **month**: Ordered factor giving the month returned from the trip.
#' * **sa2_code_tra**: Integer SA2 code used by Tourism Research Australia.
#'   This can be joined to \code{\link{tourism_region}}.
#' * **stop_reason**: Integer reason code that can be joined to
#'   \code{\link{tourism_reason_name}}.
#' * **trips**: Estimated number of overnight trips, in thousands.
#' * **n_sample**: Number of survey responses supporting the estimate.
#'
#' @details
#' Records for which either \code{trips} or \code{n_sample} equals zero are
#' excluded. Estimates with small sample sizes should be interpreted with
#' appropriate caution.
#'
#' @references
#' Tourism Research Australia: \url{https://www.tra.gov.au}
#'
#' @seealso \code{\link{tourism_reason_name}},
#'   \code{\link{tourism_activity}}, \code{\link{tourism_region}}
#' @docType data
#' @name tourism_reason
#' @usage tourism_reason
#' @examples
#' data(tourism_reason)
#' head(tourism_reason)
"tourism_reason"



#### tourism_reason_name ----------------------------------

#' Tourism Stopover Reason Names
#'
#' A lookup table matching the stopover reason codes in
#' \code{\link{tourism_reason}} to descriptive names.
#'
#' @format A tibble with 7 rows and 2 variables:
#' * **stop_reason**: Integer stopover reason code.
#' * **name**: Descriptive name of the stopover reason.
#'
#' @references
#' Tourism Research Australia: \url{https://www.tra.gov.au}
#'
#' @seealso \code{\link{tourism_reason}}
#' @docType data
#' @name tourism_reason_name
#' @usage tourism_reason_name
#' @examples
#' data(tourism_reason_name)
#' tourism_reason_name
"tourism_reason_name"



#### tourism_activity -------------------------------------

#' Monthly Tourism Trips by Stopover Activity
#'
#' Estimated domestic overnight trips to Australian SA2 areas by month and
#' stopover activity. The data contain only observations with non-zero trip
#' estimates and non-zero survey sample sizes.
#'
#' @format A tibble with 320,188 rows and 6 variables:
#' * **year**: Calendar year, from 2014 to 2024.
#' * **month**: Ordered factor giving the month returned from the trip.
#' * **sa2_code_tra**: Integer SA2 code used by Tourism Research Australia.
#'   This can be joined to \code{\link{tourism_region}}.
#' * **stop_activity**: Integer activity code that can be joined to
#'   \code{\link{tourism_activity_name}}.
#' * **trips**: Estimated number of overnight trips, in thousands.
#' * **n_sample**: Number of survey responses supporting the estimate.
#'
#' @details
#' Records for which either \code{trips} or \code{n_sample} equals zero are
#' excluded. Estimates with small sample sizes should be interpreted with
#' appropriate caution.
#'
#' @references
#' Tourism Research Australia: \url{https://www.tra.gov.au}
#'
#' @seealso \code{\link{tourism_activity_name}},
#'   \code{\link{tourism_reason}}, \code{\link{tourism_region}}
#' @docType data
#' @name tourism_activity
#' @usage tourism_activity
#' @examples
#' data(tourism_activity)
#' head(tourism_activity)
"tourism_activity"



#### tourism_activity_name --------------------------------

#' Tourism Stopover Activity Names
#'
#' A lookup table matching the stopover activity codes in
#' \code{\link{tourism_activity}} to descriptive names.
#'
#' @format A tibble with 8 rows and 2 variables:
#' * **stop_activity**: Integer stopover activity code.
#' * **name**: Descriptive name of the stopover activity.
#'
#' @references
#' Tourism Research Australia: \url{https://www.tra.gov.au}
#'
#' @seealso \code{\link{tourism_activity}}
#' @docType data
#' @name tourism_activity_name
#' @usage tourism_activity_name
#' @examples
#' data(tourism_activity_name)
#' tourism_activity_name
"tourism_activity_name"



#### oz_sa2 -----------------------------------------------

#' Australian Statistical Area Level 2 Boundaries
#'
#' Simplified 2021 Statistical Area Level 2 (SA2) polygon boundaries for the
#' SA2 codes used in Tourism Research Australia exports. Representative
#' interior-point coordinates are included for analyses that need one point
#' per SA2.
#'
#' @format An \code{sf} data frame with 2,350 rows and 4 variables:
#' * **sa2_code_tra**: Integer SA2 identifier used by Tourism Research
#'   Australia. This field can be joined to \code{\link{tourism_reason}},
#'   \code{\link{tourism_activity}}, and \code{\link{tourism_region}}.
#' * **lat**: Latitude of a representative point located within the SA2,
#'   in decimal degrees.
#' * **lon**: Longitude of a representative point located within the SA2,
#'   in decimal degrees.
#' * **geometry**: Simplified SA2 polygon or multipolygon geometry in GDA2020
#'   (EPSG:7844).
#'
#' @details
#' Boundaries were obtained from the Australian Bureau of Statistics ASGS
#' Edition 3 digital boundary files. Full-resolution polygons were matched to
#' TRA codes by state and SA2 name. Representative points were calculated from
#' the full-resolution geometry in Australian Albers (EPSG:3577), using a point
#' guaranteed to lie on the SA2 surface. Polygon geometry was simplified with
#' \pkg{rmapshaper}, retaining five percent of removable vertices while
#' preserving shapes and shared boundaries.
#'
#' @source Australian Bureau of Statistics,
#' \href{https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs/edition-3-july-2021-june-2026/access-and-downloads/digital-boundary-files}{ASGS Edition 3 digital boundary files}.
#'
#' @references
#' Australian Bureau of Statistics. Australian Statistical Geography Standard
#' (ASGS), Edition 3, July 2021--June 2026.
#'
#' @seealso \code{\link{tourism_region}}, \code{\link{tourism_reason}},
#'   \code{\link{tourism_activity}}
#' @docType data
#' @name oz_sa2
#' @usage oz_sa2
#' @examples
#' data(oz_sa2)
#' head(oz_sa2)
"oz_sa2"
