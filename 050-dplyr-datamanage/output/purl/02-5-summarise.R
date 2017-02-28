## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages and data
require(tidyverse)  # alternatively require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
# Compute the mean of balance variable of bank data frame
summarise(bank, mean_balance = mean(balance, na.rm = TRUE))
# Compute the minimum and the maximum value of balance of bank data frame
bank %>% summarise(max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
bank %>% summarise(first(job))

## ------------------------------------------------------------------------
bank %>% summarise(last(job)) 

## ------------------------------------------------------------------------
bank %>% summarise(nth(job, 8))

## ------------------------------------------------------------------------
bank %>% summarise(n())

## ------------------------------------------------------------------------
bank %>% summarise(n_distinct(job))
bank %>% summarise(n_distinct(education))

