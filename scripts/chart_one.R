# Script for returning chart 1
library("dplyr")
library("leaflet")

# Function the returns a different visualization, scatterplot by long/lat

aggregating_occurence_by_location <- function (data_set) {
  suppressWarnings(leaflet(data = data_set) %>%
    addProviderTiles("Esri") %>%
    addCircleMarkers(
      lat = ~Latitude,
      lng = ~Longitude,
      radius = ~VEI * 1.5,
      color = "red",
      stroke = FALSE, fillOpacity = 0.5
    ))
}
