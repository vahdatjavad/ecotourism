## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
source("vignette-utils.R")

## ----echo=FALSE---------------------------------------------------------------
# global variables
organism_name <- "gouldian_finch"
organism_title <- "Gouldian finch"
taxa     <- "Gouldian finch"
start    <- 2014
end      <- 2024

## ----"request data ALA", eval=FALSE, message=FALSE, warning=FALSE, include=FALSE----
# 
# organism <- obs_data(taxa, start, end) |> polished_data()
# # Save data
# mysave(organism_name, organism)

## ----"print head of data", echo=FALSE-----------------------------------------
organism <- myload(organism_name)
organism |> slice_head(n = 3) |> as_tibble() |> glimpse()

## ----"number of occ in state", echo=FALSE-------------------------------------
organism |> my_count(scientificName, obs_state, f=1) |> as_tibble() 

## ----echo=FALSE, fig.width=6, fig.height=4------------------------------------
# Clean and prepare data
organism |> plot_map1(color_by = scientificName)


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


## ----echo=FALSE, fig.height=6, fig.width=8, message=FALSE, warning=FALSE------
plot_monthly_distribution_map(organism_name)

