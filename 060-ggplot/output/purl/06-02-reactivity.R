## ----reactivity----------------------------------------------------------
x <- 10
y <- 10*2

## ----reactivity2---------------------------------------------------------
x <- 20
y

## ----reactivity3---------------------------------------------------------
print(input$yearInput)

## ----reactivity4---------------------------------------------------------
observe({print(input$yearInput)})

## ----reactive5-----------------------------------------------------------

timeSpan <- diff(input$yearInput)


## ----reactive6-----------------------------------------------------------
timeSpan <- reactive({
  diff(input$yearInput)
})

## ----reactive7-----------------------------------------------------------
observe({ print(timeSpan()) })

## ----reactivity8---------------------------------------------------------
filtered <- reactive({
  df %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
           align == input$alignInput,
           sex == input$genderInput) %>%
    group_by(year) %>%
    summarise(new_chars = n())
})

## ----reavtivity9---------------------------------------------------------

server <- function(input, output) {
  filtered <- reactive({
  df %>% 
    filter(year >= input$yearInput[1],
           year <= input$yearInput[2],
           align == input$alignInput,
           sex == input$genderInput) %>%
    group_by(year) %>%
    summarise(new_chars = n())
})

  output$timeSeries <- renderPlot({
  ggplot(filtered, aes(x = year, y = new_chars)) +
    geom_line()
})
  
  output$tableResults <- renderDataTable({
    filtered()
})
}


