## use function in pure R style: this improves the code but does not improve the efficiency of the code, 
## so that the filtered function is run twice.

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
	
	filtered <- function(){
		
		message("filtered called")
		
		filtered <- comics_data %>% 
			filter(year >= input$yearInput[1],
						 year <= input$yearInput[2],
						 align == input$alignInput,
						 publisher == input$publisherInput) %>%
			group_by(year, sex) %>%
			summarise(new_chars = n())
	}
	
	output$timeSeries <- renderPlot({
		
		ggplot(filtered(), aes(x = year, y = new_chars, group = sex)) +
			geom_line(aes(colour = sex))
		
	})
	output$tableResults <- renderDataTable({
		
		filtered()
		
	})
	
}

shinyApp(ui = ui, server = server)
