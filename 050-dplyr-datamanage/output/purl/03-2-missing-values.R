## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages and data
require(tidyverse) 
require(qdata)

## ---- include=TRUE, purl=TRUE--------------------------------------------
NA+1
NA == 1
x <- c(1, 2, 3, 4, NA); mean(x)

## ---- include=TRUE, purl=TRUE--------------------------------------------
is.na(x)

## ----setwd, eval=FALSE---------------------------------------------------
## setwd("./data")

## ---- include=TRUE, purl=TRUE--------------------------------------------
# example of different types of missing data
load("unemployment.Rda")

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment %>% summarise(mean(unemployment_rate))

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment %>% summarise(mean(lab_force_participation))

## ---- include=TRUE, purl=TRUE--------------------------------------------
y <- c(1, 2, 3, "")
mean(y)

## ---- include=TRUE, purl=TRUE--------------------------------------------
na_if(y, "")

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment_new <- na_if(unemployment, 999.99)

unemployment_new

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment %>% complete(year, sem)

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment_new <- unemployment_new %>% complete(year, sem)

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment_new %>% drop_na()

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment_new %>% 
  summarise_at(vars(unemployment_rate, lab_force_participation), funs(mean), na.rm = TRUE)

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment <- tibble(
  year = c(2014, NA, 2015, NA, 2016, NA),
  sem = c(1, 2, 1, 2, 1, 2),
  unemployment_rate = c(6.5, 7.6, 8.2, 7.3, NA, 6.8),
  lab_force_participation = c(63.5, 61.4, NA, 62.7, 61.8, 63.2)
)

## ---- include=TRUE, purl=TRUE--------------------------------------------
unemployment %>% fill(year)

