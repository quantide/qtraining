## ----setup, echo=FALSE, message=FALSE, results='hide'--------------------
library(knitr) 
options(width=80)
opts_chunk$set(list(dev = 'png', fig.cap='', fig.show='hold', dpi=100, fig.width=7, fig.height=7, fig.pos='H!'))#, fig.path="figures/lm-"))
source("r/show-solution.R")
# ATTENZIONE: leggere nota dentro show-solution.R

## ----require, echo=TRUE, message=FALSE, results='hide'-------------------
library(dplyr)
library(nycflights13)

## ----ex1, echo=show_solution, eval=show_solution-------------------------
## select(flights, month, day, air_time, distance)
## 
## # Alternative solution
## vars <- c("month", "day", "air_time", "distance")
## select(flights, one_of(vars))

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## select(flights, -hour, -minute)
## 
## # Alternative solution
## vars <- c("hour", "minute")
## select(flights, -one_of(vars))

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## select(flights, ends_with("time"))

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## select(flights, contains("delay"))

## ----ex5, echo=show_solution, eval=show_solution-------------------------
## select(flights, tail_num = tailnum)

## ----ex6, echo=show_solution, eval=show_solution-------------------------
## rename(flights, tail_num = tailnum)

