## ----radioButtons, eval = FALSE------------------------------------------
## radioButtons("typeInput", "Gender",
##                   choices = c("Female Characters", "Male Characters"),
##                   selected = "Female Characters")

## ----selectInput---------------------------------------------------------

selectInput("alignInput", "Character Type",
            choices = c("Good Characters", "Bad Characters", "Neutral Characters")),


## ----sliderInput1--------------------------------------------------------

sliderInput("yearInput", "Year", 1939, 2013, c(1990, 1995)))


## ----sliderInput2--------------------------------------------------------
library(shiny)
df <- read_csv("../data/marvel-wikia-data.csv")

ui <- fluidPage(
  titlePanel("Comic Characters"),
  em("Here is a visualisation of Comic Characters Data"), 
  sidebarLayout(
    sidebarPanel(
      radioButtons("genderInput", "Gender",
                  choices = c("Female Characters", "Male Characters"),
                  selected = "Female Characters"),
      selectInput("alignInput", "Character Type",
                  choices = c("Good Characters", "Bad Characters", "Neutral Characters")),
      sliderInput("yearInput", "Year", 1939, 2013, c(1990, 1995))),
    mainPanel("the results will go here")
  )
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)

