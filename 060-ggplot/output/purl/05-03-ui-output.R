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
      radioButtons("genderInput", "Gender",
                  choices = c("Female Characters", "Male Characters"),
                  selected = "Female Characters"),
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

