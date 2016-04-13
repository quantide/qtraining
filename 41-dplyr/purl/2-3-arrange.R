## ----first, include=FALSE, purl=TRUE, message=FALSE----------------------
# This code chunk contains R code already described in the previous chapters
# that is required by following examples
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
arrange(bank, date, age)

## ------------------------------------------------------------------------
arrange(bank, desc(age))

## ------------------------------------------------------------------------
bank[order(bank$date, bank$age), ]
bank[order(desc(bank$age)), ]

