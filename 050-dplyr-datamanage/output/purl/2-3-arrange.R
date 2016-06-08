## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(qdata)
data(bank)
bank <- tbl_df(bank)

## ------------------------------------------------------------------------
# Order `bank` data frame by date and age in ascending order
arrange(bank, date, age)

## ------------------------------------------------------------------------
# Order `bank` data frame by age in descending order
arrange(bank, desc(age))

## ------------------------------------------------------------------------
bank[order(bank$date, bank$age), ]
bank[order(desc(bank$age)), ]

