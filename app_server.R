# Load in packages
library("dplyr")
library("tidyr")
library("shiny")
library("leaflet")
library("rsconnect")

# Load in and change data set for the 3 charts/widgets
volcano_data_set <- read.csv("data/volcano_1980.csv", stringsAsFactors = FALSE)
volcano_data_set <- volcano_data_set[-1, ]

# Data set wrangling for map
volcano_map <- volcano_data_set %>%
  select(Name, Year, Longitude, Latitude, VEI, DEATHS, Country)

unique_countries <- volcano_data_set %>%
  select(Country) %>%
  distinct(Country)

unique_countries_long_lat <- volcano_data_set %>%
  select(Country, Latitude, Longitude, VEI) %>%
  group_by(Country) %>%
  arrange(Country)

# Application server
my_server <- function(input, output) {
  
  # First chart ------------------------------
  output$country_to_choose <- renderPrint({
    input$country_to_display
  })
  
  output$map <- renderLeaflet({
    # Select long and lat based on country chosen
    if (input$country_to_display == "All") {
      suppressWarnings(leaflet(data = unique_countries_long_lat) %>%
        addProviderTiles("Esri") %>%
        addCircleMarkers(
          lat = ~Latitude,
          lng = ~Longitude,
          radius = ~VEI * 1.5,
          color = "red",
          stroke = FALSE, fillOpacity = 0.5
      ))
    } else {
      unique_countries_long_lat <- filter(unique_countries_long_lat,
                                          Country == input$country_to_display)
      avg_long <- mean(unique_countries_long_lat$Longitude, na.rm = TRUE)
      avg_lat <- mean(unique_countries_long_lat$Latitude, na.rm = TRUE)
      
      suppressWarnings(leaflet(data = unique_countries_long_lat) %>%
        addProviderTiles("Esri") %>%
        addCircleMarkers(
          lat = ~Latitude,
          lng = ~Longitude,
          radius = ~VEI * 1.5,
          color = "red",
          stroke = FALSE, fillOpacity = 0.5
          ) %>%
        flyTo(avg_long, avg_lat, zoom = 3)
      )  
    }
  })
  
  # Second chart -------------------
  
}