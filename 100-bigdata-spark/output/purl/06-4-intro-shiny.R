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

