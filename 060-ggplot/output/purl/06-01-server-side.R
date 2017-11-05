## ----plot1---------------------------------------------------------------
output$timeSeries <- renderPlot({
  plot.ts(rnorm(100))
})


## ----plot2, eval = TRUE--------------------------------------------------
require(tidyverse)

load("../data/comics_data.RData")

ggplot(comics_data %>% 
       group_by(year, sex) %>%
       summarise(new_chars = n()), aes(x = year, y = new_chars, group = sex)) +
  geom_line(aes(colour = sex))


## ------------------------------------------------------------------------
require(tidyverse)
require(shiny)

load("../data/comics_data.RData")

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

server <- function(input, output) {
  output$timeSeries <- renderPlot({
    new_df <- comics_data %>% 
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
  filtered <- comics_data %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
           align == input$alignInput,
           publisher == input$publisherInput) %>%
    group_by(year, sex) %>%
    summarise(new_chars = n())
  ggplot(filtered, aes(x = year, y = new_chars, group = sex)) +
    geom_line(aes(colour = sex))
})
}


## ------------------------------------------------------------------------

  output$tableResults <- renderDataTable({
    filtered <- comics_data %>% 
      filter(year >= input$yearInput[1],
             year <= input$yearInput[2],
             align == input$alignInput,
             publisher == input$publisherInput) %>%
      group_by(year, publisher) %>%
      summarise(new_chars = n())
    filtered
})


## ------------------------------------------------------------------------

require(tidyverse)
require(shiny)

load("../data/comics_data.RData")

ui <- fluidPage(
  titlePanel("Comic Characters"),
  em("Here is a visualisation of Comic Characters Data"), 
      br(), 
      br(),
  sidebarLayout(
    sidebarPanel(
      radioButtons("publisherInput", "Publisher", choices = c("DC", "Marvel"),
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

server <- function(input, output) {
output$timeSeries <- renderPlot({
  filtered <- comics_data %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
           align == input$alignInput,
           publisher == input$publisherInput) %>%
    group_by(year, sex) %>%
    summarise(new_chars = n())
  ggplot(filtered, aes(x = year, y = new_chars, group = sex)) +
    geom_line(aes(colour = sex))
})
  output$tableResults <- renderDataTable({
    filtered <- comics_data %>% 
      filter(year >= input$yearInput[1],
             year <= input$yearInput[2],
             align == input$alignInput,
             publisher == input$publisherInput) %>%
      group_by(year, publisher) %>%
      summarise(new_chars = n())
    filtered
})

}

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
              fluidRow(
                box(selectInput("alignInput", "Character Type",
                                choices = c("Good Characters", "Bad Characters", "Neutral Characters"))),
                box(title = "Select year", sliderInput("yearInput2", "Year", 1939, 2013, c(1990, 2013))),
                box(dataTableOutput("tableResults"), width = 12)))
      )
    )
  )


server <- function(input, output) {
output$timeSeries <- renderPlot({
  filtered <- comics_data %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
           publisher == input$publisherInput) %>%
    group_by(year, sex) %>%
    summarise(new_chars = n())
  ggplot(filtered, aes(x = year, y = new_chars, group = sex)) +
    geom_line(aes(colour = sex))
})
  output$tableResults <- renderDataTable({
    filtered <- comics_data %>% 
      filter(align == input$alignInput,
             year >= input$yearInput2[1],
             year <= input$yearInput2[2]) %>%
      group_by(year, publisher) %>%
      summarise(new_chars = n())
    filtered
})

}

shinyApp(ui = ui, server = server)


