## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
require(dplyr)
require(qdata)
data(bank)

## ------------------------------------------------------------------------
bank <- tbl_df(bank)
arrange(bank, date, age)

## ------------------------------------------------------------------------
arrange(bank, desc(age))

## ------------------------------------------------------------------------
bank[order(bank$date, bank$age), ]
bank[order(desc(bank$age)), ]

