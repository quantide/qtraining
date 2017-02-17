## ----readr---------------------------------------------------------------
require(tidyverse)

## ----readr2, message=FALSE-----------------------------------------------
require(readr)
require(dplyr)
require(tibble)

## ----getwd, eval = FALSE-------------------------------------------------
## getwd()

## ----setwd, eval=FALSE---------------------------------------------------
## setwd("./data")

## ----tennis1-------------------------------------------------------------
read_table("tennis.txt", col_names = TRUE)

## ----csvs, eval = FALSE--------------------------------------------------
## read_csv("solar.txt", col_names = TRUE) # for comma separeted variables
## read_tsv("aire_milano.txt", col_names = TRUE) # for tab separeted variables
## read_csv2("milano_tourism", col_names= TRUE) # for semi colon separeted variables

## ----delim---------------------------------------------------------------
read_delim("solar.txt", col_names = TRUE, delim = ",")
read_delim("tuscany.txt", col_names = TRUE, delim = "|")

