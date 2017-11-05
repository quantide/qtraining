## ----plotOutput----------------------------------------------------------
plotOutput("timeSeries")

## ----tableOutput---------------------------------------------------------
tableOutput("tableResults")

## ----tableOutput2--------------------------------------------------------
dataTableOutput("tableResults")

## ----finalUI-------------------------------------------------------------
library(shiny)
df <- read_csv("../data/marvel-wikia-data.csv")

ui <- fluidPage(
  titlePanel("Comic Characters"),
  em("Here is a visualisation of Comic Characters Data"), 
      br(), 
      br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("publisherInput", "Publisher",
                  choices = c("DC", "Marvel"),
                  selected = "DC"),
      br(),
      br(),
      selectInput("alignInput", "Character Type",
                  choices = c("Good Characters", "Bad Characters", "Neutral Characters")),
      br(),
      br(),
      sliderInput("yearInput", "Year", 1939, 2013, c(1990, 1995))),
    mainPanel(plotOutput("timeSeries"),
              br(),
              br(),
              dataTableOutput("tableResults"))
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)

## ----shinydashboard------------------------------------------------------

library(shiny)
library(shinydashboard)

load("../data/comics_data.RData")


ui <- dashboardPage(
    dashboardHeader(title = "Comic characters Data"),
    ## Sidebar content
    dashboardSidebar(
      sidebarMenu(
        menuItem("Plot", tabName = "plot", icon = icon("th")),
        menuItem("Summary", tabName = "summary", icon = icon("th"))
        )
      ),

## Body content
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "plot",
        fluidRow(
          box(title = "Choose publisher", radioButtons( "publisherInput", "Publisher",
                  choices = c("DC", "Marvel"),
                  selected = "DC")),
          box(title = "Select year", sliderInput("yearInput", "Year", 1939, 2013, c(1990, 2013))
              ),
          box(plotOutput("timeSeries"), width = 12)
        )),
      # Second tab content
      tabItem(tabName = "summary",
        h2(box(dataTableOutput("tableResults"))))
      )
    )
  )

server <- function(input, output) {}

shinyApp(ui = ui, server = server)

