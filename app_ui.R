# Load in packages
library("rsconnect")
library("shiny")

# Application UI
intro_page <- tabPanel(
  "Introduction Page",
  tags$h1("Introduction",
          style = "font-family: cursive;
          color: #4d3a7d;"
  ),
  sidebarLayout(
    sidebarPanel(
      tags$div(class = "info", checked = NA,
        tags$p("Terminology: The Volcanic Explosivity Index (VEI) is a relative measure of the explosiveness of volcanic eruptions.")
      )
    ),
    mainPanel(
      # an introduction
      tags$div(class = "introduction", checked = NA,
        tags$p("As a group, we were interested in the various natural phenomena that occurs around us and decided to delve deeper
                into an environmental structure that currently has tremendous impact on us in Seattle, Washington, and that would
                be Mount Rainier. Some of us have taken/are currently taking a volcanos course and we believe this would be another
                way to learn more about this topic, as it can greatly affect our awareness of volcanic activity. We source our volcano
                data (from 1980 to 2019) from the"),
        tags$a(href="https://www.ngdc.noaa.gov/nndc/servlet/ShowDatasets?dataset=102557&search_look=50&display_look=50", 
                      "Significant Volcano Eruption Database"),
        tags$hr(),

        tags$p("Below is the three questions we are seeking to answer"),
        
        # List of 2 questions we are seeking to answer
        tags$ol(
          tags$li("Where did the eruptions occur from 1980 to 2019? We created a hazard map which includes all the volcanic eruptions
                  occured from 1980 to 2019 around the world"), 
          tags$li("What is the most dangerous type of volcano? To answer this question, we created a pie chart
                  and the dangerous level can be measured by number of death, number of people missing, number of people injured or the
                  total damage in Dollars. The pie chart can include different types of volcano for comparison.")
        ),
        
        # picture of a volcano
        tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Augustine_volcano_Jan_24_2006_-_Cyrus_Read.jpg/1200px-Augustine_volcano_Jan_24_2006_-_Cyrus_Read.jpg", width = "600px", height = "400px"),
        style = "font-family: cursive;
                color: #000000;
                font-size: 18px;"
      )

    )
  )
)

chart_one <- tabPanel(
  "Hazard Map",
  tags$h1("Hazard Map",
          style = "font-family: cursive;
          color: #4d3a7d;"
  ),
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
  "Dangers of Volcano Types",
  tags$h1("Dangers of Volcano Types",
          style = "font-family: cursive;
          color: #4d3a7d;"
  ),
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
  tags$h1("conclusion",
          style = "font-family: cursive;
          color: #4d3a7d;"
  ),
  sidebarLayout(
    sidebarPanel(
      tags$div(class = "info", checked = NA,
               tags$p("Info 201 Section AD Group 5
                      Created By : Yishuan Chung & Chris Cheng & Yafei Wang")
      )
    ),
    mainPanel(
      tags$div(class = "conclusion", checked = NA,
        tags$p("First takeaway: Based on the hazard map (measured by VEI) below, we found that volcanic eruptions usually occur along the coast of ", tags$strong("Pacific Ocean"),
               ". Especially near south east asia and western caribbean."),
        tags$img(src = 'hazardmap.png', width = "600px", height = "400px"),

        tags$p("Second takeaway: The below pie chart (damage based on dollars) shows that ", tags$strong("Stratovolcano"), "is the
               most dangerous type of volcano as it filled about 85% of the pie chart."),
        tags$img(src = 'piechart.png', width = "500px", height = "400px"),
        style = "font-family: cursive;
                 color: #000000;
                 font-size: 18px;"
      )
    )
  )
)

my_ui <- shinyUI(navbarPage(
  "Volcano Information",
  intro_page,
  chart_one,
  chart_two,
  summary_page
))
