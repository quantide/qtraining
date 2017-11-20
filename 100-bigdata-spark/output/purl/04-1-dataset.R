## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(eval = FALSE)

## cd ~

## head -n 5 2008.csv

## 	

## ------------------------------------------------------------------------
ontime <- read.table(file = "~/data/ontime.csv", header = T, sep = ",", quote = "\"")

## head -n 30000 2008.csv > mini.csv

## ------------------------------------------------------------------------
csv_file <- "~/data/mini.csv"
R_df <- read.table(file = csv_file, header = T, sep = ",", quote = "\"")
R_df

