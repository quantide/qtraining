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
## flights_red <- flights %>% select(year:day, hour, origin, dest, tailnum, carrier)
## flights_red %>% left_join(y = airlines, by = "carrier")
## 
## # Alternative solution
## # (since carrier name is the only variable which is present in both datasets)
## flights_red %>% left_join(y = airlines)

## ----ex1_bis, echo=show_solution, eval=FALSE-----------------------------
## # If you want to avoid the warning, first be sure that both carrier variables
## # are character. In this case, before joining execute:
## airlines$carrier <- as.character(airlines$carrier)

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## airports_red <-
##   airports %>%
##   select(faa, name, lat, lon, alt)
## 
## # Two different datasets
## flights_red %>% left_join(y = airports_red, by = c("origin" = "faa"))
## flights_red %>% left_join(y = airports_red, by = c("dest" = "faa"))
## 
## # All in one dataset
## flights_red %>%
##   left_join(y = airports_red, by = c("origin" = "faa")) %>%
##   left_join(y = airports_red, by = c("dest" = "faa"))

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## flights_red %>% inner_join(y = airports_red, by = c("dest" = "faa"))

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## flights_red %>% full_join(y = airports_red, by = c("dest" = "faa"))

## ----ex5, echo=show_solution, eval=show_solution-------------------------
## flights_red %>% anti_join(y = airports_red, by = c("dest" = "faa"))

## ----ex6, echo=show_solution, eval=show_solution-------------------------
## planes_sorted <- planes %>% arrange(year)
## (old_planes <- planes_sorted %>% filter(year < 2000))
## (new_planes <- planes_sorted %>% setdiff(old_planes))
## new_planes %>% bind_rows(old_planes)

