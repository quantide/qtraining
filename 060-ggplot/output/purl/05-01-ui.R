## ----shiny-title, eval = FALSE-------------------------------------------
## 
## ui <- fluidPage(
##   titlePanel("Comic Characters Data")
## )
## 

## ----shiny-text, eval = FALSE--------------------------------------------
## 
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   "Here is a visualisation of Comic Characters Data"
## )
## 
## 

## ----shiny-text2, eval = FALSE-------------------------------------------
## 
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   em("Here is a visualisation of Comic Characters Data")
## )
## 

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

## ----shiny-sidebar1, eval = FALSE----------------------------------------
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   em("Here is a visualisation of Comic Characters Data"),
##   sidebarLayout(
##     sidebarPanel("our inputs will go here"),
##     mainPanel("the results will go here")
##   )
## )

## ----shiny-sidebar2, eval = FALSE----------------------------------------
## ui <- fluidPage(
##   titlePanel("Comic Characters"),
##   em("Here is a visualisation of Comic Characters Data"),
##   sidebarLayout(
##     sidebarPanel("our inputs will go here"),
##     mainPanel("the results will go here", width = 4)
##   )
## )

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



## ----shiny-navlistPanel--------------------------------------------------

ui <- fluidPage(
  titlePanel("Comic Characters"),
  navlistPanel(
    "",
    tabPanel("Plot"),
    tabPanel("Summary")
  )
)


## ----shinydashboard1-----------------------------------------------------

ui <- dashboardPage(
  dashboardHeader(title = "Comic characters"),
  dashboardSidebar(),
  dashboardBody()
)


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



## ----shinydashboard3-----------------------------------------------------

  dashboardSidebar(
    sidebarMenu(
      menuItem("Plot", tabName = "plot", icon = icon("th")),
      menuItem("Summary", tabName = "summary", icon = icon("th"))
    )
  )


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



