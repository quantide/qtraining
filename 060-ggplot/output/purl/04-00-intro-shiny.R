## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(tidyverse)

## ---- eval = FALSE-------------------------------------------------------
## install.packages("shiny")

## ---- eval = FALSE-------------------------------------------------------
## library(shiny)
## runExample("01_hello")

## ----load-data-----------------------------------------------------------
require(tidyverse)
df <- read_csv("../data/marvel-wikia-data.csv")

## ----data-explore--------------------------------------------------------
str(df)

