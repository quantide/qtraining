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
##   do(data.frame(p = (1:3)/4,
##                 quantile = quantile(.$arr_delay, probs = (1:3)/4, na.rm = TRUE)))

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## flights %>%
##   group_by(origin) %>%
##   summarise(q25 = quantile(arr_delay, probs = .25, na.rm = TRUE),
##             q50 = median(arr_delay, na.rm = TRUE),
##             q75 = quantile(arr_delay, probs = .75, na.rm = TRUE))

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## statistics <- function(x, ...)  {
##   ss <- c(mean = mean(x, ...), sd = sd(x, ...))
##   return(ss)
## }
## flights %>%
##   group_by(origin) %>%
##   do(data.frame(stats = c("mean", "sd") , value = statistics(.$arr_delay, na.rm = TRUE)))

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## flights %>%
##   group_by(origin) %>%
##   summarise(mean = mean(arr_delay, na.rm = TRUE),
##             sd = sd(arr_delay, na.rm = TRUE))

