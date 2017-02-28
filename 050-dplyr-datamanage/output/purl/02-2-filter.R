## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages and data
require(tidyverse)    # alternatively require(dplyr)
require(lubridate)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
filter(bank, job == "student", balance > 20000)

## ------------------------------------------------------------------------
bank %>% filter(job == "student", as.character(date) == "2008-05-05")
bank %>% filter(job == "student", date == ymd("2008-05-05"))

## ------------------------------------------------------------------------
# Select all calls made to people of 18 or 95 years
bank %>% filter(age == 18 | age == 95)

## ------------------------------------------------------------------------
# Select all calls made to people of 18 or 95 years
bank %>% filter(age %in% c(18,95))

## ------------------------------------------------------------------------
# Select all calls made to people whose job is admin. or technician 
bank %>% filter(job %in% c("admin.","technician"))
# Select all calls made to people whose job is admin. or technician 
bank %>% filter(job == "admin." | job == "technician")

## ------------------------------------------------------------------------
slice(bank, 1:5)

## ------------------------------------------------------------------------
# select last row of the dataset
bank %>% slice(n()) 

## ------------------------------------------------------------------------
sample_n(bank, 3)

## ------------------------------------------------------------------------
sample_frac(bank, 0.0001)
sample_frac(bank, 1.5, replace = TRUE)

