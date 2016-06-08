## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(qdata)
require(lubridate)
data(bank)

## ------------------------------------------------------------------------
filter(bank, job == "student", balance > 20000)

## ------------------------------------------------------------------------
filter(bank, job == "student", as.character(date) == "2008-05-05")
filter(bank, job == "student", date == ymd("2008-05-05"))

## ------------------------------------------------------------------------
# Select all calls made to people of 18 or 95 years
filter(bank, age == 18 | age == 95)

## ------------------------------------------------------------------------
# Select all calls made to people of 18 or 95 years
filter(bank, age %in% c(18,95))

## ------------------------------------------------------------------------
# Select all calls made to people whose job is admin. or technician 
filter(bank, job %in% c("admin.","technician"))
# Select all calls made to people whose job is admin. or technician 
filter(bank, job == "admin." | job == "technician")

## ------------------------------------------------------------------------
slice(bank, 1:5)

## ------------------------------------------------------------------------
# select last row of the dataset
slice(bank, n()) 

## ------------------------------------------------------------------------
sample_n(bank, 3)

## ------------------------------------------------------------------------
sample_frac(bank, 0.0001)
sample_frac(bank, 1.5, replace = TRUE)

