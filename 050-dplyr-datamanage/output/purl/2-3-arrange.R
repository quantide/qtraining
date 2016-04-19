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
## arrange(flights, year, month, day, hour, minute)

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## arrange(flights, desc(arr_delay))

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## arrange(flights, origin, desc(arr_delay))

