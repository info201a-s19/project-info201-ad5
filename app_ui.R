# Load in packages
library("ggplot2")
library("rsconnect")

# Application UI
intro_page <- tabPanel(
  "Introduction Page",
  titlePanel(),
  sidebarLayout(
    sidebarPanel(),
    mainPanel()
  )
)

chart_one <- tabPanel(
  "Hazard Map",
  titlePanel("Hazard Map"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel()
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
