## reactiveEvent substituted by observeEvent plus a reactiveValues

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
			radioButtons("publisherInput", "Publisher", choices = c("DC", "Marvel"),
									 selected = "DC"),
			br(),
			br(),
			selectInput("alignInput", "Character Type",
									choices = c("Good Characters", "Bad Characters", "Neutral Characters")),
			br(),
			br(),
			sliderInput("yearInput", "Year", 1939, 2013, c(1990, 1995)),
			actionButton(inputId = "apply", label = "Apply")
		),
		mainPanel(plotOutput("timeSeries"),
							br(),
							br(),
							dataTableOutput("tableResults"))
	)
)


server <- function(input, output) {
	
	data <- reactiveValues(filtered = NULL, 
												 a = 1, 
												 b = 2)
	
	observeEvent( input$apply, ignoreNULL = FALSE, {
		
		message("filtered called")
		
		data$filtered <- comics_data %>% 
			filter(year >= input$yearInput[1],
						 year <= input$yearInput[2],
						 align == input$alignInput,
						 publisher == input$publisherInput) %>%
			group_by(year, sex) %>%
			summarise(new_chars = n())
	})
	
	output$timeSeries <- renderPlot({
		
		ggplot(data$filtered, aes(x = year, y = new_chars, group = sex)) +
			geom_line(aes(colour = sex))
		
	})
	output$tableResults <- renderDataTable({
		
		data$filtered
		
	})
	
}

shinyApp(ui = ui, server = server)
