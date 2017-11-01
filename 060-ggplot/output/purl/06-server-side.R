## ----output--------------------------------------------------------------
output$timeSeries <- renderPlot({
  plot(rnorm(100))
})


## ------------------------------------------------------------------------
require(tidyverse)

ggplot(df %>% 
       group_by(year) %>%
       summarise(new_chars = n()), aes(x = year, y = new_chars)) +
  geom_line()


## ------------------------------------------------------------------------
require(tidyverse)
require(shiny)

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

server <- function(input, output) {
  output$timeSeries <- renderPlot({
    new_df <- df %>% 
         group_by(year) %>%
         summarise(new_chars = n())
    ggplot(new_df, aes(x = year, y = new_chars)) + 
      geom_line()
})
}

shinyApp(ui = ui, server = server)


## ------------------------------------------------------------------------

server <- function(input, output) {
output$timeSeries <- renderPlot({
  filtered <-df %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
           align == input$alignInput,
           sex == input$genderInput) %>%
    group_by(year) %>%
    summarise(new_chars = n())
  ggplot(filtered, aes(x = year, y = new_chars)) +
    geom_line()
})
}


## ------------------------------------------------------------------------

  output$tableResults <- renderDataTable({
    filtered <-df %>% 
      filter(year >= input$yearInput[1],
             year <= input$yearInput[2],
             align == input$alignInput,
             sex == input$genderInput) %>%
      group_by(year) %>%
      summarise(new_chars = n())
    filtered
})


## ------------------------------------------------------------------------

require(tidyverse)
require(shiny)

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

server <- function(input, output) {
output$timeSeries <- renderPlot({
  filtered <-df %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
           align == input$alignInput,
           sex == input$genderInput) %>%
    group_by(year) %>%
    summarise(new_chars = n())
  ggplot(filtered, aes(x = year, y = new_chars)) +
    geom_line()
})
  output$tableResults <- renderDataTable({
    filtered <-df %>% 
      filter(year >= input$yearInput[1],
             year <= input$yearInput[2],
             align == input$alignInput,
             sex == input$genderInput) %>%
      group_by(year) %>%
      summarise(new_chars = n())
    filtered
})
}

shinyApp(ui = ui, server = server)


