# server.R ----------------------------------------------------------------

server <- function(input, output) {
	
	data <- reactiveValues(filtered = NULL, 
												 filtered_2 = NULL)
	
	observe( {
		
		message("observe apply")
		
		data$filtered <- comics_data %>% 
			filter(year >= input$yearInput[1],
						 year <= input$yearInput[2],
						 align == input$alignInput,
						 publisher == input$publisherInput) %>%
			group_by(year, sex) %>%
			summarise(new_chars = n())
		
		data$filtered_2 <- comics_data %>% 
			filter(year >= input$yearInput[1],
						 year <= input$yearInput[2],
						 align == input$alignInput) %>%
			group_by(year, sex) %>%
			summarise(new_chars = n())
		
	})
	
	output$timeSeries <- renderPlot({
		
		message("render timeSeries")
		
		ggplot(data$filtered, aes(x = year, y = new_chars, group = sex)) +
			geom_line(aes(colour = sex))
		
	})
	output$tableResults <- renderDataTable({
		
		message("render tableResults")
		
		data$filtered_2
		
	})
	
	
}
