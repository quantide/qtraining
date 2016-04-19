## ----setup, echo=FALSE, results='hide', message=FALSE--------------------
library(knitr) 
options(width=80)
opts_chunk$set(list(dev = 'png', fig.cap='', fig.show='hold', dpi=100, fig.width=7, fig.height=7, fig.pos='H!'))#, fig.path="figures/lm-"))
source("r/show-solution.R")
# ATTENZIONE: leggere nota dentro show-solution.R

## ----require, results='hide', message=FALSE------------------------------
library(dplyr)
library(tidyr)
library(nycflights13)

## ----ex1_intro, echo=TRUE, eval=TRUE-------------------------------------
heartrate_wide <- data.frame(
  name = c("Aldo", "Giovanni", "Giacomo"),
  surname = c("Baglio", "Storti", "Poretti"),
  morning = c(67, 80, 64),
  afternoon = c(56, 90, 50)
)
heartrate_wide

## ----ex1, echo=show_solution, eval=show_solution-------------------------
## (heartrate_long <- heartrate_wide %>%
##    gather(key = time, value = heartrate, morning:afternoon))

## ----ex2, echo=show_solution, eval=show_solution-------------------------
## heartrate_long %>% spread(time, heartrate)

## ----ex3, echo=show_solution, eval=show_solution-------------------------
## (heartrate_united <- heartrate_wide %>%
##    unite(col = complete_name, name, surname, sep = " "))

## ----ex4, echo=show_solution, eval=show_solution-------------------------
## heartrate_united %>%
##   separate(col = complete_name, into = c("name","surname"))

