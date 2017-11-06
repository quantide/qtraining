## ----radioButtons, eval = FALSE------------------------------------------
## radioButtons("publisherInput", "Publisher",
##                   choices = c("DC", "Marvel"),
##                   selected = "DC")

## ----selectInput---------------------------------------------------------

selectInput("alignInput", "Character Type",
            choices = c("Good Characters", "Bad Characters", "Neutral Characters"))


## ----sliderInput1--------------------------------------------------------

sliderInput("yearInput", "Year", 1939, 2013, c(1990, 1995))


## ----sliderInput2--------------------------------------------------------
library(shiny)

load("../data/comics_data.RData")

ui <- fluidPage(
  titlePanel("Comic Characters"),
  em("Here is a visualisation of Comic Characters Data"), 
  sidebarLayout(
    sidebarPanel(
      radioButtons("publisherInput", "Publisher",
                  choices = c("DC", "Marvel"),
                  selected = "DC"),
      selectInput("alignInput", "Character Type",
                  choices = c("Good Characters", "Bad Characters", "Neutral Characters")),
      sliderInput("yearInput", "Year", 1939, 2013, c(1990, 2013))),
    mainPanel("the results will go here")
  )
)

server <- function(input, output) {}

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
								)
							),
							# Second tab content
							tabItem(tabName = "summary",
											h2("Some output")
							)
			)
		)
	)
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)

