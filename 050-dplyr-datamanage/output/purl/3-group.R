## ----setup, echo=FALSE, results='hide', message=FALSE--------------------
library(knitr) 
options(width=80)
opts_chunk$set(list(dev = 'png', fig.cap='', fig.show='hold', dpi=100, fig.width=7, fig.height=7, fig.pos='H!'))#, fig.path="figures/lm-"))
source("r/show-solution.R")
# ATTENZIONE: leggere nota dentro show-solution.R

## ----require, results='hide', message=FALSE------------------------------
library(dplyr)
library(nycflights13)

## ----ex1, echo=show_solution, eval=show_solution-------------------------
## flights_by_month <- group_by(flights, month)
## summarise(flights_by_month,
##           n = n(),
##           min_delay = min(arr_delay, na.rm = TRUE),
##           max_delay = max(arr_delay, na.rm = TRUE),
##           mean_delay = mean(arr_delay, na.rm = TRUE))

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## flights_by_origin <- group_by(flights, origin)
## summarise(flights_by_origin,
##           n = n(),
##           mean_dep_delay = mean(dep_delay, na.rm = TRUE),
##           mean_arr_delay = mean(arr_delay, na.rm = TRUE))

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## destinations <- group_by(flights, dest)
## summarise(destinations,
##           planes = n_distinct(tailnum),
##           flights = n())

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## daily <- group_by(flights, year, month, day)
## (per_day <- summarise(daily, flights = n()))

## ----ex5, echo=show_solution, eval=show_solution-------------------------
## (per_month <- summarise(per_day, flights = sum(flights)))

## ----ex6, echo=show_solution, eval=show_solution-------------------------
## n_days <- c(31,28,31,30,31,30,31,31,30,31,30,31)
## mutate(per_month, n_days = n_days, daily_mean = flights / n_days)

