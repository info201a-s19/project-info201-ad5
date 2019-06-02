# Load in packages
library("rsconnect")
library("shiny")

# Application UI
intro_page <- tabPanel(
  "Introduction Page",
  titlePanel("Introduction Page"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel()
  )
)

chart_one <- tabPanel(
  "Hazard Map",
  titlePanel("Hazard Map"),
  sidebarLayout(
    sidebarPanel(
      
      # Select country to display
      selectInput(
        inputId = "country_to_display",
        label = "Country Volcanic Activity to Display",
        choices = c("All", unique_countries)
      )
    ),
    mainPanel(
      leafletOutput("map")
    )
  )
)

chart_two <- tabPanel(
  "Predominant Volcano Types in Different Countries",
  titlePanel("Predominant Volcano Types in Different Countries"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel()
  )
)

chart_three <- tabPanel(
  "Dangers of Volcano Types",
  titlePanel("Dangers of Volcano Types"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel()
  )
)

summary_page <- tabPanel(
  "Conclusion Page",
  titlePanel("Conclusion Page"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel()
  )
)

my_ui <- shinyUI(navbarPage(
  "Volcano Information",
  intro_page,
  chart_one,
  chart_two,
  chart_three,
  summary_page
))
