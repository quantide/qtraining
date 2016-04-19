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
## flights %>%
##   group_by(origin) %>%
##   summarise(n = n(),
##             mean_distance = mean(distance),
##             mean_dep_delay = mean(dep_delay, na.rm = TRUE),
##             mean_arr_delay = mean(arr_delay, na.rm = TRUE))

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## flights %>%
##   group_by(year, month) %>%
##   summarise(n = n(),
##             mean_dep_delay = mean(dep_delay, na.rm = TRUE),
##             mean_arr_delay = mean(arr_delay, na.rm = TRUE)) %>%
##   mutate(mean_gained_time = mean_dep_delay - mean_arr_delay)

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## flights %>%
##   group_by(year, month, day) %>%
##   select(arr_delay, dep_delay) %>%
##   summarise(
##     arr = mean(arr_delay, na.rm = TRUE),
##     dep = mean(dep_delay, na.rm = TRUE)
##     ) %>%
##   filter(arr > 30 | dep > 30)

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## weather %>%
##   filter(origin == "EWR") %>%
##   group_by(month, day) %>%
##   summarise(min_visib = min(visib, na.rm = TRUE)) %>%
##   filter(min_visib <= 5)

