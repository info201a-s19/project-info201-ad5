# Load in packages
library("dplyr")
library("tidyr")
library("shiny")
library("leaflet")
library("ggplot2")
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
  select(Country, Latitude, Longitude, VEI, DEATHS, Name) %>%
  group_by(Country) %>%
  arrange(Country)

# Data wrangle for volcano type, pie chart
volcano_pie_chart <- volcano_data_set %>%
  select(Type, DEATHS, MISSING, INJURIES, DAMAGE_MILLIONS_DOLLARS)

# Application server
my_server <- function(input, output) {
  
  # First chart ------------------------------
  output$country_to_choose <- renderPrint({
    input$country_to_display
  })
  
  output$map <- renderLeaflet({
    # Select long and lat based on country chosen, choose circle mappings
    radius_style <- 
    if (input$map_circles == "VEI") {
      radius_style <- unique_countries_long_lat$VEI
    } else {
      radius_style <- unique_countries_long_lat$DEATHS
    }
    
    if (input$country_to_display == "All") {
      suppressWarnings(leaflet(data = unique_countries_long_lat) %>%
        addProviderTiles("Esri") %>%
        addCircleMarkers(
          lat = ~Latitude,
          lng = ~Longitude,
          radius = if (input$map_circles == "VEI") {
            ~VEI * 2
          } else {
            ~DEATHS / 500
          },
          color = "red",
          stroke = FALSE, fillOpacity = 0.5,
          label = ~Name
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
          radius = if (input$map_circles == "VEI") {
            ~VEI * 2
          } else {
            ~DEATHS / 500
          },
          color = "red",
          stroke = FALSE, fillOpacity = 0.5,
          label = ~Name
          ) %>%
        flyTo(avg_long, avg_lat, zoom = 3)
      )  
    }
  })
  
  # Second chart -------------------
  
  
  # Third chart --------------------
  output$piechart <- renderPlot({
    # Set info to be captured
    info_selection <- ""
    if (input$damage_measurement == "Deaths") {
      info_selection <- "DEATHS"
    } else if (input$damage_measurement == "Injured") {
      info_selection <- "INJURIES"
    } else if (input$damage_measurement == "Missing") {
      info_selection <- "MISSING"
    } else {
      info_selection <- "DAMAGE_MILLIONS_DOLLARS"
    }
    
    # Filter data based on input of data to compare
    volcano_pie_temp <- volcano_pie_chart %>%
      group_by(Type) %>%
      replace(is.na(.), 0) %>%
      summarise_each(sum) %>%
      select(Type, info_selection) %>%
      filter(Type %in% input$volcano_type)
    names(volcano_pie_temp)[names(volcano_pie_temp) == info_selection] <- "value"
    
    if (dim(volcano_pie_temp)[1] != 0) {
      ggplot(data = volcano_pie_temp, aes(x = "", y = value, fill = Type)) +
        geom_bar(width = 1, stat = "identity") +
        coord_polar("y", start = 0) +
        theme(axis.line = element_blank(),
              plot.title = element_text(hjust = 0.5)) +
        scale_fill_manual(values = c("#55DDE0", "#33658A", "#2F4858", "#F6AE2D",
                                     "#F26419", "#999999", "#75d986", "#42f495",
                                     "#e5f441", "#c16c8a")) +
        labs(x = NULL, y = NULL, fill = NULL, title =
               paste0("Damage Proportions")) +
        theme_classic() + theme(axis.line = element_blank(),
                                axis.text = element_blank(),
                                axis.ticks = element_blank(),
                                plot.title = element_text(hjust =
                                                            0.5, color = "#7c7c8a"))
    }
  })
}