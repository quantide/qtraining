## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
by_year <- group_by(bank, year)
summarise(by_year,
          count = n(),
          mean_duration = mean(duration, na.rm = TRUE),
          mean_balance = mean(balance, na.rm = TRUE))

## ------------------------------------------------------------------------
summarise(by_year,
          days = n_distinct(date),
          count = n())

## ------------------------------------------------------------------------
daily <- group_by(bank, year, month, day)
(per_day <- summarise(daily, calls = n()))
(per_month <- summarise(per_day, calls = sum(calls)))
(per_year <- summarise(per_month, calls = sum(calls)))

