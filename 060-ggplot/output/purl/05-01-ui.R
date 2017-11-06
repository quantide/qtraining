## ----shiny-empty, eval = FALSE-------------------------------------------
## library(shiny)
## 
## ui <- fluidPage()
## server <- function(input, output) {}
## 
## shinyApp(ui = ui, server = server)

## ----shiny-title, eval = FALSE-------------------------------------------
## 
## ui <- fluidPage(
##   titlePanel("Comic Characters Data")
## )
## 
## shinyApp(ui = ui, server = server)

## ----shiny-text, eval = FALSE--------------------------------------------
## 
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   "Here is a visualisation of Comic Characters Data"
## )
## 
## shinyApp(ui = ui, server = server)

## ----shiny-text2, eval = FALSE-------------------------------------------
## 
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   em("Here is a visualisation of Comic Characters Data")
## )
## 
## shinyApp(ui = ui, server = server)

## ----shiny-splitLayout1, eval = FALSE------------------------------------
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   em("Here is a visualisation of Comic Characters Data"),
##   splitLayout(cellWidths = c("25%", "75%"),
##     em("one plot goes here"),
##     em("another plot goes here")
##   )
## )
## 
## shinyApp(ui = ui, server = server)

## ----shiny-sidebar1, eval = FALSE----------------------------------------
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   em("Here is a visualisation of Comic Characters Data"),
##   sidebarLayout(
##     sidebarPanel("our inputs will go here"),
##     mainPanel("the results will go here")
##   )
## )
## 
## shinyApp(ui = ui, server = server)

## ----shiny-sidebar2, eval = FALSE----------------------------------------
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   em("Here is a visualisation of Comic Characters Data"),
##   sidebarLayout(
##     sidebarPanel("our inputs will go here"),
##     mainPanel("the results will go here", width = 4)
##   )
## )
## 
## shinyApp(ui = ui, server = server)

## ----shiny-tabsetPanel---------------------------------------------------

ui <- fluidPage(
  titlePanel("Comic Characters"),
  em("Here is a visualisation of Comic Characters Data"),
    mainPanel(tabsetPanel(
      tabPanel("Plot"),
      tabPanel("Summary")
    )
  )
)

shinyApp(ui = ui, server = server)

## ----shiny-navlistPanel--------------------------------------------------

ui <- fluidPage(
  titlePanel("Comic Characters"),
  navlistPanel(
    "",
    tabPanel("Plot"),
    tabPanel("Summary")
  )
)

shinyApp(ui = ui, server = server)

## ----shinydashboard1-----------------------------------------------------
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Comic characters"),
  dashboardSidebar(),
  dashboardBody()
) 
server <- function(input, output) { }
 
shinyApp(ui, server)

## ----shinydashboard2-----------------------------------------------------
ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(),
  dashboardBody(
    fluidRow(
      box(),
      box()
    )
  )
)

shinyApp(ui, server)

## ----shinydashboard3-----------------------------------------------------
ui <- dashboardPage(
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(
  	sidebarMenu(
  		menuItem("Plot", tabName = "plot", icon = icon("th")),
  		menuItem("Summary", tabName = "summary", icon = icon("th"))
  	)
  ),
  dashboardBody(
    fluidRow(
      box(),
      box()
    )
  )
)

shinyApp(ui, server)

## ----shinydashboard4-----------------------------------------------------

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
          box(),
          box()
        )
      ),

      # Second tab content
      tabItem(tabName = "summary",
        h2("Some output")
      )
    )
  )
)

server <- function(input, output) { }
 
shinyApp(ui, server)  

