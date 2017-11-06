## ----reactivity----------------------------------------------------------
x <- 10
y <- 10*2

## ----reactivity2---------------------------------------------------------
x <- 20
y

## ----reactivity3---------------------------------------------------------
print(input$yearInput)

## ----reactivity4---------------------------------------------------------
observe({print(input$yearInput)})

## ----reactive5-----------------------------------------------------------

timeSpan <- diff(input$yearInput)


## ----reactive6-----------------------------------------------------------
timeSpan <- reactive({
  diff(input$yearInput)
})

## ----reactive7-----------------------------------------------------------
observe({ print(timeSpan()) })

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

## ----reactivity8---------------------------------------------------------
filtered <- reactive({
  comics_data %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
					 align == input$alignInput,
					 publisher == input$publisherInput) %>%
    group_by(year, publisher) %>%
    summarise(new_chars = n())
})

## ----reavtivity9---------------------------------------------------------

server <- function(input, output) {
	filtered <- reactive({
		comics_data %>% 
			filter(year >= input$yearInput[1],
						 year <= input$yearInput[2],
						 align == input$alignInput,
						 publisher == input$publisherInput) %>%
			group_by(year, sex) %>%
			summarise(new_chars = n())
	})
	output$timeSeries <- renderPlot({
		ggplot(filtered(), aes(x = year, y = new_chars, group = sex)) +
			geom_line(aes(colour = sex))
	})
	output$tableResults <- renderDataTable({
		filtered()
	})
}

shinyApp(ui = ui, server = server)

