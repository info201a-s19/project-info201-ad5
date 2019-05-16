# Script for returning chart 1
library("dplyr")
library("leaflet")

# Load in data set for testing
volcano_data_set <- read.csv("data/volcano_1980.csv", stringsAsFactors = FALSE)

# Function the returns a different visualization, scatterplot by long/lat

aggregating_occurence_by_location <- function (data_set) {
  suppressWarnings(leaflet(data = data_set) %>%
    addProviderTiles("CartoDB.Positron") %>%
    addCircleMarkers(
      lat = ~Latitude,
      lng = ~Longitude,
      radius = ~VEI * 1.5,
      color = "red",
      stroke = FALSE, fillOpacity = 0.5
    ))
}

