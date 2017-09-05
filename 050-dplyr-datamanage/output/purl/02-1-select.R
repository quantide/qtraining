## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages and data
require(tidyverse)
require(qdata)
data(bank) 

## ----bank----------------------------------------------------------------
# Select columns: year, month and day of bank data frame
select(bank, year, month, day)
# Select columns: year, month and day of bank data frame
bank %>% select(year:day)
# Select all columns of bank data frame apart from: year, month and day
bank %>% select(-(year:day))

## ------------------------------------------------------------------------
# Rename id variable as ID
bank %>% select(ID = id)

## ------------------------------------------------------------------------
bank %>% select(contains("d"))

## ------------------------------------------------------------------------
bank %>% select(ends_with("tion"))

## ------------------------------------------------------------------------
bank %>% select(starts_with("d"))

## ------------------------------------------------------------------------
bank %>% select(everything())
# change the order of columns
bank %>% select(ends_with("tion"), everything() ) 

## ------------------------------------------------------------------------
# match all variables containing "r", but not at the first place
bank %>% select(matches(".r")) 

## ------------------------------------------------------------------------
data(tennis)
wimbledon
wimbledon %>% select(num_range("s", c(1:3, 5)))

## ------------------------------------------------------------------------
bank %>% select(one_of(c("marital","education")))
vars <- c("marital","education")
bank %>% select(one_of(vars))

## ------------------------------------------------------------------------
bank %>% select(job:balance)

## ------------------------------------------------------------------------
bank %>% select(-job)
bank %>% select(-starts_with("d"))

## ------------------------------------------------------------------------
starts_with("b", vars=names(bank))

## ------------------------------------------------------------------------
select_if(bank, is.factor)    # select only string variables
select_if(bank, is.numeric)   # select only numeric values

## ------------------------------------------------------------------------
# find out unique values of housing variable of bank data frame
distinct(select(bank, housing))
# find out combinations of unique values of housing and loan variables of bank data frame
distinct(select(bank, housing, loan))

## ------------------------------------------------------------------------
# Rename id variable as ID
bank %>% rename(ID = id)

