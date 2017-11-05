## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(tidyverse)

## ---- eval = FALSE-------------------------------------------------------
## install.packages("shiny")

## ---- eval = FALSE-------------------------------------------------------
## library(shiny)
## runExample("01_hello")

## ----load-data-----------------------------------------------------------
require(tidyverse)
load("../data/comics_data.RData")

## ----data-explore--------------------------------------------------------
str(comics_data)

## ----data-explore2-------------------------------------------------------
pp <- ggplot(comics_data %>%
         filter(!is.na(sex)) %>%
         group_by(year, sex) %>%
         summarise(new_chars = n()), aes(x=year, y=new_chars, sex)) +
  geom_line(aes(colour = sex))
pp


## ----data-explore3-------------------------------------------------------
pp2 <- ggplot(comics_data %>%
         filter(!is.na(sex)) %>%
         group_by(year, sex, publisher) %>%
         summarise(new_chars = n()), aes(x=year, y=new_chars, sex)) +
  geom_line(aes(colour = sex)) + facet_grid( ~ publisher)
pp2


