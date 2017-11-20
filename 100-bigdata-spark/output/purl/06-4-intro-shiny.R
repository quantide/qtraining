## ---- eval = FALSE-------------------------------------------------------
## install.packages("shiny")

## ---- eval = FALSE-------------------------------------------------------
## library(shiny)
## runExample("01_hello")

## ----my-first-shiny-app, eval = FALSE------------------------------------
## library(shiny)
## 
## ui <- fluidPage()
## server <- function(input, output) {}
## 
## shinyApp(ui = ui, server = server)

## ----shinydashboard------------------------------------------------------
library(shiny)
library(shinydashboard)
 
ui <- dashboardPage(
     dashboardHeader(),
     dashboardSidebar(),
     dashboardBody()
)
 
server <- function(input, output) { }
 
shinyApp(ui, server)

## ------------------------------------------------------------------------

# global --------
library(shiny)
library(shinydashboard)
library(sparklyr) 
library(ggplot2)
library(dplyr)

sc <- spark_connect( master = "local", version = "2.0.0" )

csv_file <- "/data/2008.csv"

 ## read data
spark_table <- spark_read_csv(
	sc = sc,
	name = "year2008",
	path = csv_file
)


# ui --------
ui <- dashboardPage(
	dashboardHeader(),
	dashboardSidebar(
		numericInput('minCount', label = "Minimun count", step = 5, value = 20)
	),
	dashboardBody(
		plotOutput('plot')
	)
)

# server -------
server <- function(input, output) { 
	
	output$plot <- renderPlot({
		## Collect some data
		delay <-
			spark_table %>% 
			group_by(TailNum) %>%
			summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
			filter(count > input$minCount, dist < 2000, !is.na(delay)) %>%
			collect()
		## Plot delays
		ggplot(delay, aes(dist, delay)) +
			geom_point(aes(size = count), alpha = 1/2) 
	})
}

# run --------
shinyApp(ui, server)

