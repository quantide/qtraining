## ----first, include=TRUE, purl=TRUE, message=FALSE-----------------------
# load packages and data
require(tidyverse) 
require(qdata)
data(bank) 

## ------------------------------------------------------------------------
# Order `bank` data frame by date and age in ascending order
arrange(bank, date, age)

## ------------------------------------------------------------------------
# Order `bank` data frame by age in descending order
bank %>% arrange(desc(age))

## ------------------------------------------------------------------------
bank[order(bank$date, bank$age), ]
bank[order(desc(bank$age)), ]

