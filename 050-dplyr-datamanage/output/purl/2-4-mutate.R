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
## flights2 <- mutate(flights,
##                    gained_time = dep_delay - arr_delay,
##                    speed = distance / air_time * 60)
## select(flights2, dep_delay, arr_delay, gained_time, distance, air_time, speed)

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## transmute(flights,
##           gained_time = dep_delay - arr_delay,
##           speed = distance / air_time * 60)

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## sorted_flights <- arrange(flights, year, month, day, hour, minute)
## delay <- select(sorted_flights, dep_delay, arr_delay)
## mutate(delay, delta_delay = dep_delay - lag(dep_delay))

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## mutate(delay, delay_rank = min_rank(arr_delay))

## ----ex5, echo=show_solution, eval=show_solution-------------------------
## mutate(delay, delay_rank = row_number(arr_delay))

## ----ex6, echo=show_solution, eval=show_solution-------------------------
## mutate(delay, delay_rank = between(dep_delay, -3, 3))

