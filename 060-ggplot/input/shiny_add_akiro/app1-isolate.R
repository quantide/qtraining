## actionButton and Isolate

require(tidyverse)
require(shiny)

load("data/comics_data.RData")

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
			sliderInput(inputId = "yearInput", label = "Year", 1939, 2013, c(1990, 1995)),
			br(),
			actionButton(inputId = "apply", label = "Apply")),
		mainPanel(plotOutput(outputId = "timeSeries"),
							br(),
							br(),
							dataTableOutput("tableResults"))
	)
)

server <- function(input, output) {
	
	output$timeSeries <- renderPlot({
		
		input$apply

		startYear <- isolate(input$yearInput[1])

		filtered <- comics_data %>% 
			filter(year >=  startYear,
						 year <= isolate(input$yearInput[2]),
						 align == isolate(input$alignInput),
						 publisher == isolate(input$publisherInput)) %>%
			group_by(year, sex) %>%
			summarise(new_chars = n())
		
		input$alignInput
		
		ggplot(filtered, aes(x = year, y = new_chars, group = sex)) +
			geom_line(aes(colour = sex))
	})
}

shinyApp(ui = ui, server = server)


name <- function(a) {
	b <- 3
}