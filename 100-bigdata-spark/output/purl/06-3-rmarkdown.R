## ---- eval=FALSE---------------------------------------------------------
## install.packages("rmarkdown")

## ----eval=FALSE----------------------------------------------------------
## require(rmarkdown)
## render("example.Rmd")

## ----print table---------------------------------------------------------
data(mtcars)
head(mtcars)

## ----kable---------------------------------------------------------------
knitr::kable(head(mtcars))

## ------------------------------------------------------------------------
# ---
# 	title: "Big data report"
# ---
# 	
# 	```{r, echo=FALSE, message=FALSE, include=FALSE, purl=FALSE}  
# options(width = 108)
# show_chunk <- function(x){
# 	cat(x)
# }
# require(knitr)
# ```  
# 
# ```{r init, echo = FALSE}
# 
# # global --------
# library(shiny)
# library(shinydashboard)
# library(sparklyr) 
# library(ggplot2)
# library(dplyr)
# 
# sc <- spark_connect( master = "local", version = "2.0.0" )
# 
# csv_file <- "/data/2008.csv"
# 
# ## read data
# spark_table <- spark_read_csv(
# 	sc = sc,
# 	name = "year2008",
# 	path = csv_file
# )
# 
# ```
# 
# ```{r aggregation}
# ## Collect some data
# delay <-
# 	spark_table %>% 
# 	group_by(TailNum) %>%
# 	summarise(count = n(), dist = mean(Distance), delay = mean(ArrDelay)) %>%
# 	filter(count > 20, dist < 2000, !is.na(delay)) %>%
# 	collect()
# 
# delay
# ```
# 
# ```{r plot}
# ## Plot delays
# ggplot(delay, aes(dist, delay)) +
# 	geom_point(aes(size = count), alpha = 1/2) 
# 
# ```

