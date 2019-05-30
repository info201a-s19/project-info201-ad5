# Load in packages
library("shiny")
source("app_ui.R")
source("app_server.R")

# Load shiny application
shinyApp(ui = my_ui, server = my_server)