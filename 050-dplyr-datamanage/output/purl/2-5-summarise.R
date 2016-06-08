## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
# Compute the mean of balance variable of bank data frame
summarise(bank, mean_balance = mean(balance, na.rm = TRUE))
# Compute the minimum and the maximum value of balance of bank data frame
summarise(bank, max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
summarise(bank, first(job))

## ------------------------------------------------------------------------
summarise(bank, last(job)) 

## ------------------------------------------------------------------------
summarise(bank, nth(job, 8))

## ------------------------------------------------------------------------
summarise(bank, n())

## ------------------------------------------------------------------------
summarise(bank, n_distinct(job))
summarise(bank, n_distinct(education))

