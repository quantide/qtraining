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
## filter(flights, dep_delay > 1000)

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## filter(flights, dep_delay > 900 | arr_delay > 900)

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## filter(flights, month == 12 & day == 25 & origin == "EWR" & dest == "IAH")

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## slice(flights, 1:5)

## ----ex5, echo=show_solution, eval=show_solution-------------------------
## slice(flights, (n()-9):n())

## ----ex6, echo=show_solution, eval=show_solution-------------------------
## select(filter(flights, dep_delay > 1000), distance)

