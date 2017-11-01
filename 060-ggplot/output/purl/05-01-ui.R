## ----shiny-title, eval = FALSE-------------------------------------------
## 
## ui <- fluidPage(
##   titlePanel("Comic Characters")
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

