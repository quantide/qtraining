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
## summarise(flights,
##           min_delay = min(arr_delay, na.rm = TRUE),
##           max_delay = max(arr_delay, na.rm = TRUE),
##           mean_delay = mean(arr_delay, na.rm = TRUE))

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## flights_jan <- filter(flights, month == 1)
## summarise(flights_jan,
##           min_delay = min(arr_delay, na.rm = TRUE),
##           max_delay = max(arr_delay, na.rm = TRUE),
##           mean_delay = mean(arr_delay, na.rm = TRUE))

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## summarise(flights, n = n(), n_carriers = n_distinct(carrier))

