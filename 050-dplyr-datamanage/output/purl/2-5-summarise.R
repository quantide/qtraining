## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
summarise(bank, mean_balance = mean(balance, na.rm = TRUE))
summarise(bank, max_balance = max(balance, na.rm = TRUE), min_balance = min(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
summarise(bank, first(job))

## ------------------------------------------------------------------------
summarise(bank, last(job))

## ------------------------------------------------------------------------
summarise(bank, nth(job,8))

## ------------------------------------------------------------------------
summarise(bank, n())

## ------------------------------------------------------------------------
summarise(bank, n_distinct(job))
summarise(bank, n_distinct(education))

