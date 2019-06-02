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
      ),
      
      # Select what to map hazard levels
      selectInput(
        inputId = "map_circles",
        label = "What to map the hazard levels with",
        choices = c("VEI", "Deaths")
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
    sidebarPanel(
      selectInput(
        inputId = "damage_measurement",
        label = "Source of Damage to Measure With",
        choices = c("Deaths", "Missing", "Injured", "Damage in Dollars")
      ),
      checkboxGroupInput("volcano_type", label =
                           h3("Choose Volcano Type to Display"),
                         choices = list("Stratovolcano",
                                        "Tuff cone",
                                        "Complex volcano",
                                        "Maar",
                                        "Caldera",
                                        "Shield volcano",
                                        "Pyroclastic shield",
                                        "Cinder cone",
                                        "Subglacial volcano",
                                        "Lava dome"),
                         selected = "Stratovolcano")
      
    ),
    mainPanel(
      plotOutput("piechart")
    )
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
