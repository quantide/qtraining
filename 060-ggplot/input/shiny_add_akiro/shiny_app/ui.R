# ui.R --------------------------------------------------------------------

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


